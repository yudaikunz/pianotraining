import SwiftUI

struct PracticeView: View {
    let song: Song
    let difficulty: Difficulty
    /// 曲＋難易度から一度だけ読み込む演奏データ。
    /// 計算プロパティにすると body の再評価のたびにMusicXMLを再パースしてしまい、
    /// `PlayedNote.id`（UUID）が毎回変わって、落ちてくる音符と楽譜の表示が
    /// ちぐはぐに見える・発音管理がずれる原因になるため、初期化時に一度だけ確定する。
    let arrangement: Arrangement
    /// 五線譜の和音レイアウト。currentBeat に依存しないので init で一度だけ計算し、
    /// 再生中（20Hz）の body 再評価のたびに全音符をグループ化／ソートし直すのを防ぐ。
    let chordInfos: [UUID: ChordInfo]

    @State private var currentBeat: Double = 0
    @State private var isPlaying = false
    @State private var soundingNoteIDs: Set<UUID> = []

    /// 設定画面で選んだ再生スピード（テンポ倍率）。全曲共通で適用される
    @AppStorage(AppSettings.playbackSpeedKey) private var playbackSpeed = 1.0

    /// iPad（横幅に余裕がある画面）かどうか。楽譜・鍵盤を拡大表示するために使う
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @StateObject private var soundEngine = PianoSoundEngine()

    init(song: Song, difficulty: Difficulty) {
        self.song = song
        self.difficulty = difficulty
        let arrangement = SampleArrangements.arrangement(for: song.id, difficulty: difficulty)
        self.arrangement = arrangement
        self.chordInfos = StaffNotationView.computeChordInfos(for: arrangement.notes)
    }

    private var hasLeftHandPart: Bool {
        arrangement.notes.contains { $0.hand == .left }
    }

    /// 鍵盤の表示範囲（最低音・オクターブ数）をアレンジに含まれる音域から自動計算する。
    /// 片手のみの曲は2オクターブ程度、両手の曲は低音側に伴奏が広がるため
    /// それに合わせて鍵盤も広く表示し、落ちてくる音符と常に一致するようにする。
    private var keyboardRange: (lowestPitch: Int, octaveCount: Int) {
        let pitches = arrangement.notes.map(\.pitch)
        guard let minPitch = pitches.min(), let maxPitch = pitches.max() else {
            return (60, 2)
        }
        let lowestC = (minPitch / 12) * 12
        let highestC = (maxPitch / 12 + 1) * 12
        let octaveCount = max(2, (highestC - lowestC) / 12)
        return (lowestC, octaveCount)
    }

    /// 今鳴っている鍵（MIDIノート番号 → 弾く手）。
    /// 鍵盤のハイライトを楽譜・落下ノーツと同じ手の色で光らせるために使う。
    /// 同じ鍵を両手で同時に弾く場合は右手の色を優先する。
    private var highlightedKeys: [Int: Hand] {
        var result: [Int: Hand] = [:]
        for note in arrangement.notes
        where currentBeat >= note.startBeat && currentBeat < note.startBeat + note.duration {
            if note.hand == .right || result[note.pitch] == nil {
                result[note.pitch] = note.hand
            }
        }
        return result
    }

    /// iPadなど横幅に余裕がある画面（horizontalSizeClass == .regular）では、
    /// 楽譜・落下ノーツ・鍵盤をまとめて拡大し、広い画面を活かす
    private var staffScale: CGFloat {
        horizontalSizeClass == .regular ? 1.25 : 1.0
    }

    var body: some View {
        GeometryReader { geo in
            // 画面の向き（横長かどうか）に応じて、各パーツの高さ配分を変える。
            // 縦・横どちらでも、楽譜と鍵盤＋ウォーターフォールを同時に、
            // スクロールなしで鍵盤全体が収まるように調整する。
            let isLandscape = geo.size.width > geo.size.height
            let keyboardWidth = max(geo.size.width - 32, 200)

            // iPhoneでは再生ボタンがスクロールしないと届かない位置にあると押しづらいため、
            // 再生コントロールはスクロール領域の外（画面下部に固定）に配置する。
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: isLandscape ? 10 : 12) {
                        header

                        if soundEngine.diagnosticMessage != nil {
                            audioUnavailableBanner
                        }

                        StaffNotationView(
                            arrangement: arrangement,
                            currentBeat: currentBeat,
                            isPlaying: isPlaying,
                            onBeatDragged: { beat in
                                guard !isPlaying else { return }
                                currentBeat = beat
                            },
                            chordInfos: chordInfos,
                            scale: staffScale
                        )
                        .frame(height: (isLandscape ? 208 : 264) * staffScale)
                        .padding(.horizontal)

                        practiceArea(keyboardWidth: keyboardWidth, isLandscape: isLandscape)

                        handLegend
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                }

                Divider()
                controls
                    .padding(.top, 12)
                    .padding(.bottom, isLandscape ? 12 : 8)
                    .background(Color(.systemBackground))
            }
        }
        .navigationTitle("練習")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            // 練習画面を離れたらエンジンとオーディオセッションを解放し、
            // 他アプリの音楽が中断・音量低下されたままにならないようにする
            soundEngine.teardown()
        }
        // playbackSpeedもidに含め、再生中にスピードを変更したらその場でテンポを切り替える
        .task(id: "\(isPlaying)|\(playbackSpeed)") {
            guard isPlaying else {
                stopAllSound()
                return
            }
            // Task.sleep は指定時間より長く待つことがあるため、1ティックごとに固定量を
            // 加算する方式だと曲が進むほどテンポが遅れていく。
            // 再生開始時刻からの経過実時間で拍位置を計算し、ドリフトを防ぐ。
            let beatsPerSecond = arrangement.bpm / 60 * max(playbackSpeed, 0.1)
            let startBeat = currentBeat
            let startDate = Date()
            while isPlaying && !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 50_000_000)
                currentBeat = startBeat + Date().timeIntervalSince(startDate) * beatsPerSecond
                if currentBeat >= arrangement.totalBeats {
                    currentBeat = arrangement.totalBeats
                    isPlaying = false
                }
                updateSound(for: currentBeat)
            }
        }
    }

    // MARK: - 音声再生

    /// 現在の拍位置に応じて、鳴らすべき音を発音し、終わった音を消音する。
    /// 同じ高さの音が連続/重複する場合に誤って消音しないよう、消音前に他の発音中の音と高さが被っていないか確認する。
    private func updateSound(for beat: Double) {
        let activeNotes = arrangement.notes.filter { beat >= $0.startBeat && beat < $0.startBeat + $0.duration }
        let activeIDs = Set(activeNotes.map(\.id))
        let activePitches = Set(activeNotes.map(\.pitch))

        for note in activeNotes where !soundingNoteIDs.contains(note.id) {
            soundEngine.noteOn(pitch: note.pitch)
        }
        for note in arrangement.notes where soundingNoteIDs.contains(note.id) && !activeIDs.contains(note.id) {
            if !activePitches.contains(note.pitch) {
                soundEngine.noteOff(pitch: note.pitch)
            }
        }
        soundingNoteIDs = activeIDs
    }

    private func stopAllSound() {
        soundEngine.stopAllNotes()
        soundingNoteIDs = []
    }

    // MARK: - 共通ヘッダー

    private var header: some View {
        VStack(spacing: 4) {
            Text(song.title)
                .font(.title2)
                .fontWeight(.bold)
            HStack(spacing: 8) {
                Text(song.composer)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(difficulty.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(difficulty.color.opacity(0.15))
                    .foregroundStyle(difficulty.color)
                    .clipShape(Capsule())
            }
        }
    }

    private var audioUnavailableBanner: some View {
        Label("音の準備に失敗しました。端末のサイレントスイッチやボリュームをご確認ください。", systemImage: "speaker.slash.fill")
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }

    private var handLegend: some View {
        HStack(spacing: 20) {
            legendItem(color: Hand.right.color, label: "右手（ト音記号）")
            if hasLeftHandPart {
                legendItem(color: Hand.left.color, label: "左手（ヘ音記号）")
            }
        }
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: 6) {
            Circle().fill(color).frame(width: 10, height: 10)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - 鍵盤＋ウォーターフォール（楽譜と同時に表示する）

    /// 鍵盤は画面幅に収まるように常にリサイズし、横スクロールさせない。
    /// 落ちてくる音符（ウォーターフォール）は、その鍵盤と横位置がぴったり揃う。
    private func practiceArea(keyboardWidth: CGFloat, isLandscape: Bool) -> some View {
        let range = keyboardRange
        let layout = KeyboardLayout(
            lowestPitch: range.lowestPitch,
            octaveCount: range.octaveCount,
            width: keyboardWidth,
            keyboardHeight: (isLandscape ? 104 : 128) * staffScale
        )

        return VStack(spacing: 6) {
            FallingNotesView(arrangement: arrangement, currentBeat: currentBeat, layout: layout)
                .frame(width: keyboardWidth, height: (isLandscape ? 120 : 168) * staffScale)
            PianoKeyboardView(layout: layout, highlightedKeys: highlightedKeys)
        }
        .frame(width: keyboardWidth)
        .padding(.horizontal, 16)
    }

    // MARK: - 再生コントロール

    private var controls: some View {
        VStack(spacing: 14) {
            Slider(
                value: $currentBeat,
                in: 0...max(arrangement.totalBeats, 0.01),
                onEditingChanged: { editing in
                    if editing {
                        isPlaying = false
                        stopAllSound()
                    }
                }
            )
            .tint(difficulty.color)
            .padding(.horizontal, 32)

            HStack(spacing: 24) {
                Button {
                    currentBeat = 0
                    isPlaying = false
                    stopAllSound()
                } label: {
                    Image(systemName: "backward.end.fill")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 52, height: 52)
                        .background(Circle().fill(Color(.secondarySystemBackground)))
                }

                Button {
                    if currentBeat >= arrangement.totalBeats { currentBeat = 0 }
                    if !isPlaying {
                        soundEngine.prepareForPlayback()
                    }
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .contentTransition(.symbolEffect(.replace))
                        .animation(.easeOut(duration: 0.15), value: isPlaying)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        .offset(x: isPlaying ? 0 : 2)
                        .frame(width: 72, height: 72)
                        .background(
                            Circle()
                                .fill(difficulty.color.gradient)
                                .shadow(color: difficulty.color.opacity(0.35), radius: 10, x: 0, y: 4)
                        )
                }

                speedMenu
            }
        }
    }

    /// この画面内で再生スピードを切り替えるためのメニュー（変更内容は設定画面とも共有される）
    private var speedMenu: some View {
        Menu {
            ForEach(AppSettings.playbackSpeedOptions, id: \.self) { speed in
                Button {
                    playbackSpeed = speed
                } label: {
                    let label = speed == 1.0 ? "標準 ×1" : AppSettings.speedText(speed)
                    if speed == playbackSpeed {
                        Label(label, systemImage: "checkmark")
                    } else {
                        Text(label)
                    }
                }
            }
        } label: {
            VStack(spacing: 2) {
                Image(systemName: "speedometer")
                    .font(.title3.weight(.semibold))
                Text(AppSettings.speedText(playbackSpeed))
                    .font(.caption2)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(.primary)
            .frame(width: 52, height: 52)
            .background(Circle().fill(Color(.secondarySystemBackground)))
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(song: SongLibrary.songs[0], difficulty: .beginner)
    }
}
