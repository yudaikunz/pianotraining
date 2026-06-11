import SwiftUI

struct PracticeView: View {
    let song: Song
    let difficulty: Difficulty
    /// 曲＋難易度から一度だけ読み込む演奏データ。
    /// 計算プロパティにすると body の再評価のたびにMusicXMLを再パースしてしまい、
    /// `PlayedNote.id`（UUID）が毎回変わって、落ちてくる音符と楽譜の表示が
    /// ちぐはぐに見える・発音管理がずれる原因になるため、初期化時に一度だけ確定する。
    let arrangement: Arrangement

    @State private var currentBeat: Double = 0
    @State private var isPlaying = false
    @State private var soundingNoteIDs: Set<UUID> = []

    private let soundEngine = PianoSoundEngine()

    init(song: Song, difficulty: Difficulty) {
        self.song = song
        self.difficulty = difficulty
        self.arrangement = SampleArrangements.arrangement(for: song.id, difficulty: difficulty)
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

    private var difficultyColor: Color {
        switch difficulty {
        case .superBeginner: return .green
        case .beginner:      return .blue
        case .intermediate:  return .orange
        }
    }

    var body: some View {
        GeometryReader { geo in
            // 画面の向き（横長かどうか）に応じて、各パーツの高さ配分を変える。
            // 縦・横どちらでも、楽譜と鍵盤＋ウォーターフォールを同時に、
            // スクロールなしで鍵盤全体が収まるように調整する。
            let isLandscape = geo.size.width > geo.size.height
            let keyboardWidth = max(geo.size.width - 32, 200)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: isLandscape ? 10 : 16) {
                    header

                    StaffNotationView(
                        arrangement: arrangement,
                        currentBeat: currentBeat,
                        isPlaying: isPlaying,
                        onBeatDragged: { beat in
                            guard !isPlaying else { return }
                            currentBeat = beat
                        }
                    )
                    .frame(height: isLandscape ? 168 : 224)
                    .padding(.horizontal)

                    practiceArea(keyboardWidth: keyboardWidth, isLandscape: isLandscape)

                    handLegend

                    controls
                }
                .padding(.top, 12)
                .padding(.bottom, isLandscape ? 24 : 56)
                .frame(minHeight: geo.size.height, alignment: .top)
            }
        }
        .navigationTitle("練習")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: isPlaying) {
            guard isPlaying else {
                stopAllSound()
                return
            }
            // Task.sleep は指定時間より長く待つことがあるため、1ティックごとに固定量を
            // 加算する方式だと曲が進むほどテンポが遅れていく。
            // 再生開始時刻からの経過実時間で拍位置を計算し、ドリフトを防ぐ。
            let beatsPerSecond = arrangement.bpm / 60
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
        VStack(spacing: 6) {
            Text(song.title)
                .font(.title2)
                .fontWeight(.bold)
            Text(song.composer)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(difficulty.rawValue)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .background(difficultyColor.opacity(0.15))
                .foregroundStyle(difficultyColor)
                .clipShape(Capsule())
        }
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
            keyboardHeight: isLandscape ? 104 : 128
        )

        return VStack(spacing: 6) {
            FallingNotesView(arrangement: arrangement, currentBeat: currentBeat, layout: layout)
                .frame(width: keyboardWidth, height: isLandscape ? 120 : 168)
            PianoKeyboardView(layout: layout, highlightedKeys: highlightedKeys)
        }
        .frame(width: keyboardWidth)
        .padding(.horizontal, 16)
    }

    // MARK: - 再生コントロール

    private var controls: some View {
        VStack(spacing: 14) {
            ProgressView(value: currentBeat, total: max(arrangement.totalBeats, 0.01))
                .tint(difficultyColor)
                .padding(.horizontal, 32)

            HStack(spacing: 24) {
                Button {
                    currentBeat = 0
                    isPlaying = false
                    stopAllSound()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 52, height: 52)
                        .background(Circle().fill(Color(.secondarySystemBackground)))
                }

                Button {
                    if currentBeat >= arrangement.totalBeats { currentBeat = 0 }
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        // 再生アイコン（三角形）は光学的に左へ寄って見えるため、わずかに右へ寄せて中心を合わせる
                        .offset(x: isPlaying ? 0 : 2)
                        .frame(width: 72, height: 72)
                        .background(
                            Circle()
                                .fill(difficultyColor.gradient)
                                .shadow(color: difficultyColor.opacity(0.35), radius: 10, x: 0, y: 4)
                        )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(song: SongLibrary.songs.first(where: { $0.id == "bach-minuet-g" })!, difficulty: .beginner)
    }
}
