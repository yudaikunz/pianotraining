import SwiftUI

struct ChordInfo {
    let size: Int
    let xOffset: CGFloat
}

/// 大譜表（ト音記号＝右手 / ヘ音記号＝左手）でドレミ併記の楽譜を表示する。
/// currentBeat から直接 x 座標を計算し、FallingNotesView と同期して動く。
/// 停止中はドラッグで currentBeat をスクロールできる（onBeatDragged 経由）。
struct StaffNotationView: View {
    let arrangement: Arrangement
    var currentBeat: Double = 0
    var isPlaying: Bool = false
    var onBeatDragged: ((Double) -> Void)? = nil
    /// 和音レイアウト（音符ごとの横ずらし量）。currentBeat に依存しないため、
    /// 呼び出し側（PracticeView）で一度だけ計算して渡す。nil の場合はこの場で計算する（プレビュー用）。
    var chordInfos: [UUID: ChordInfo]? = nil
    /// iPadなど横幅に余裕がある画面で楽譜全体を拡大表示するための倍率。
    /// 寸法・フォントサイズすべてに一律で適用するので、レイアウトの比率は変わらない。
    var scale: CGFloat = 1.0

    @State private var dragStartBeat: Double? = nil

    private var lineSpacing: CGFloat { 12 * scale }
    private var beatWidth: CGFloat { 34 * scale }
    /// ChordInfo の xOffset は currentBeat に依存せず一度だけ計算されるため、
    /// scale を含まない基準値を使う（描画時に `xOffset * scale` として適用する）。
    private static let noteWidth: CGFloat = 13
    private var noteWidth: CGFloat { Self.noteWidth * scale }
    private var noteHeight: CGFloat { 10 * scale }
    private var stemLength: CGFloat { 30 * scale }
    private var clefAreaWidth: CGFloat { 56 * scale }

    private let trebleBottomPitch = 64
    private let bassBottomPitch = 43
    private let middleLineStep = 4

    // 高音側の音符・臨時記号・ラベルが上端で見切れないよう、上に余白を多めに確保する
    // （加線4本分＝G6・A6あたりまでをカバーする）
    private var trebleTopY: CGFloat { 56 * scale }
    private var trebleBottomY: CGFloat { trebleTopY + lineSpacing * 4 }
    private var bassTopY: CGFloat { trebleBottomY + lineSpacing * 5 }
    private var bassBottomY: CGFloat { bassTopY + lineSpacing * 4 }
    private var contentHeight: CGFloat { bassBottomY + 30 * scale }

    private var activeNoteIDs: Set<UUID> {
        Set(arrangement.notes
            .filter { currentBeat >= $0.startBeat && currentBeat < $0.startBeat + $0.duration }
            .map(\.id))
    }

    /// 同じ拍・同じ手の音符を「和音」としてグループ化し、各音符の
    /// コード内音符数とx軸オフセットを返す。
    /// 隣接音（ダイアトニック段差 ≤1）は左右交互に配置して重なりを解消する。
    /// 表示位置（currentBeat）とは無関係に確定するので、毎フレーム再計算せず一度だけ計算する。
    static func computeChordInfos(for notes: [PlayedNote]) -> [UUID: ChordInfo] {
        struct Key: Hashable { let beat: Double; let hand: Hand }
        var result: [UUID: ChordInfo] = [:]
        let adjacentOffset: CGFloat = noteWidth + 2

        let grouped = Dictionary(grouping: notes) {
            Key(beat: $0.startBeat, hand: $0.hand)
        }
        for (_, chord) in grouped {
            let sorted = chord.sorted { $0.pitch < $1.pitch }
            let size = sorted.count
            var lastOffset: CGFloat = 0
            for (i, note) in sorted.enumerated() {
                if i > 0 {
                    let prevStep = Solfege.diatonicStep(for: sorted[i - 1].pitch)
                    let currStep = Solfege.diatonicStep(for: note.pitch)
                    lastOffset = abs(currStep - prevStep) <= 1
                        ? (lastOffset == 0 ? adjacentOffset : 0)
                        : 0
                }
                result[note.id] = ChordInfo(size: size, xOffset: lastOffset)
            }
        }
        return result
    }

    var body: some View {
        GeometryReader { geo in
            let notesAreaWidth = max(geo.size.width - clefAreaWidth, 100)
            let centerX = notesAreaWidth / 2
            let infos = chordInfos ?? Self.computeChordInfos(for: arrangement.notes)

            HStack(spacing: 0) {
                clefs
                    .frame(width: clefAreaWidth, height: contentHeight)
                    .background(Color(.systemBackground))
                    .zIndex(1)

                ZStack(alignment: .topLeading) {
                    staffLines(topY: trebleTopY, width: notesAreaWidth)
                    staffLines(topY: bassTopY, width: notesAreaWidth)
                    middleCGuide(width: notesAreaWidth)
                    barLines(centerX: centerX, areaWidth: notesAreaWidth)

                    ForEach(visibleNotes(centerX: centerX, areaWidth: notesAreaWidth)) { note in
                        let baseX = CGFloat(note.startBeat - currentBeat) * beatWidth + centerX
                        let info = infos[note.id] ?? ChordInfo(size: 1, xOffset: 0)
                        noteView(
                            for: note,
                            x: baseX + info.xOffset * scale,
                            isActive: activeNoteIDs.contains(note.id),
                            chordSize: info.size
                        )
                    }

                    playheadCursor(at: centerX)
                }
                .frame(width: notesAreaWidth, height: contentHeight)
                .clipped()
                // 停止中のみドラッグで currentBeat をスクロール
                .gesture(
                    isPlaying ? nil : DragGesture(minimumDistance: 4)
                        .onChanged { value in
                            if dragStartBeat == nil { dragStartBeat = currentBeat }
                            let delta = -Double(value.translation.width) / Double(beatWidth)
                            let newBeat = max(0, min((dragStartBeat ?? currentBeat) + delta,
                                                     arrangement.totalBeats))
                            onBeatDragged?(newBeat)
                        }
                        .onEnded { _ in dragStartBeat = nil }
                )
            }
        }
    }

    // MARK: - 再生カーソル

    private func playheadCursor(at x: CGFloat) -> some View {
        Rectangle()
            .fill(Color.orange.opacity(0.55))
            .frame(width: 2 * scale, height: bassBottomY - trebleTopY + 8 * scale)
            .position(x: x, y: (trebleTopY + bassBottomY) / 2)
    }

    // MARK: - 音部記号

    private var clefs: some View {
        VStack(spacing: 0) {
            clefGlyph("𝄞", color: Hand.right.color, label: "右手", fontSize: lineSpacing * 4.3)
                .frame(height: lineSpacing * 4 + lineSpacing * 2.5, alignment: .top)
            clefGlyph("𝄢", color: Hand.left.color, label: "左手", fontSize: lineSpacing * 2.5)
                .frame(height: lineSpacing * 4 + lineSpacing * 2.5, alignment: .top)
        }
        .padding(.top, trebleTopY - lineSpacing * 1.7)
    }

    private func clefGlyph(_ symbol: String, color: Color, label: String, fontSize: CGFloat) -> some View {
        VStack(spacing: 1) {
            Text(symbol)
                .font(.system(size: fontSize))
                .foregroundStyle(color)
            Text(label)
                .font(.system(size: 9 * scale, weight: .semibold))
                .foregroundStyle(color.opacity(0.75))
        }
    }

    // MARK: - 五線・小節線・ガイド

    private func staffLines(topY: CGFloat, width: CGFloat) -> some View {
        ForEach(0..<5, id: \.self) { i in
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: width, height: 1)
                .offset(y: topY + CGFloat(i) * lineSpacing)
        }
    }

    private func barLines(centerX: CGFloat, areaWidth: CGFloat) -> some View {
        let measureCount = max(Int(ceil(arrangement.totalBeats / arrangement.beatsPerMeasure)), 1)
        return ForEach(0...measureCount, id: \.self) { measure in
            let barBeat = Double(measure) * arrangement.beatsPerMeasure
            let x = CGFloat(barBeat - currentBeat) * beatWidth + centerX
            let isFinal = measure == measureCount
            if x > -10 && x < areaWidth + 10 {
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: isFinal ? 2.6 : 1, height: bassBottomY - trebleTopY)
                    .position(x: x, y: (trebleTopY + bassBottomY) / 2)
            }
        }
    }

    private func middleCGuide(width: CGFloat) -> some View {
        let y = (trebleBottomY + bassTopY) / 2
        return Rectangle()
            .fill(Color(.systemGray5))
            .frame(width: width, height: 1)
            .offset(y: y)
    }

    // MARK: - 音符

    private func visibleNotes(centerX: CGFloat, areaWidth: CGFloat) -> [PlayedNote] {
        arrangement.notes.filter { note in
            let x = CGFloat(note.startBeat - currentBeat) * beatWidth + centerX
            return x > -noteWidth * 3 && x < areaWidth + noteWidth * 3
        }
    }

    @ViewBuilder
    private func noteView(for note: PlayedNote, x: CGFloat, isActive: Bool, chordSize: Int) -> some View {
        let y = yPosition(for: note.pitch)
        let baseColor = note.hand.color
        let color: Color = isActive ? .orange : baseColor
        // 3音以上の和音で再生中はラベルを隠してノートヘッドのみ表示し視認性を確保
        let showLabel = isActive || !isPlaying || chordSize < 3

        Group {
            if isActive {
                Circle()
                    .fill(Color.orange.opacity(0.18))
                    .frame(width: 22 * scale, height: 22 * scale)
                    .position(x: x, y: y)
            }

            ForEach(ledgerLineYs(for: note.pitch), id: \.self) { ledgerY in
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: noteWidth + 8 * scale, height: 1)
                    .position(x: x, y: ledgerY)
            }

            stem(for: note, x: x, y: y, color: color)

            Ellipse()
                .fill(color)
                .frame(width: noteWidth, height: noteHeight)
                .rotationEffect(.degrees(-18))
                .position(x: x, y: y)

            if Solfege.isSharp(note.pitch) {
                Text("♯")
                    .font(.system(size: 12 * scale, weight: .bold))
                    .foregroundStyle(color)
                    .position(x: x - (noteWidth / 2 + 10 * scale), y: y)
            }

            if showLabel {
                Text(Solfege.baseName(for: note.pitch))
                    .font(.system(size: 10 * scale, weight: .bold))
                    .foregroundStyle(color)
                    .position(x: x, y: y + lineSpacing * 1.9)
            }
        }
    }

    private func stem(for note: PlayedNote, x: CGFloat, y: CGFloat, color: Color) -> some View {
        let bottomPitch = note.pitch >= 60 ? trebleBottomPitch : bassBottomPitch
        let relativeStep = Solfege.diatonicStep(for: note.pitch) - Solfege.diatonicStep(for: bottomPitch)
        let pointsUp = relativeStep < middleLineStep
        let stemX = x + (pointsUp ? (noteWidth / 2 - scale) : -(noteWidth / 2 - scale))
        let centerY = pointsUp ? y - stemLength / 2 : y + stemLength / 2

        return Rectangle()
            .fill(color)
            .frame(width: 1.3 * scale, height: stemLength)
            .position(x: stemX, y: centerY)
    }

    private func ledgerLineYs(for pitch: Int) -> [CGFloat] {
        let isTreble = pitch >= 60
        let bottomPitch = isTreble ? trebleBottomPitch : bassBottomPitch
        let bottomY = isTreble ? trebleBottomY : bassBottomY
        let half = lineSpacing / 2
        let relativeStep = Solfege.diatonicStep(for: pitch) - Solfege.diatonicStep(for: bottomPitch)

        if relativeStep <= -2 {
            let count = (-relativeStep) / 2
            return (1...count).map { bottomY + CGFloat(2 * $0) * half }
        }
        if relativeStep >= 10 {
            let count = (relativeStep - 8) / 2
            return (1...count).map { bottomY - CGFloat(8 + 2 * $0) * half }
        }
        return []
    }

    private func yPosition(for pitch: Int) -> CGFloat {
        if pitch >= 60 {
            let refStep = Solfege.diatonicStep(for: trebleBottomPitch)
            let steps = Solfege.diatonicStep(for: pitch) - refStep
            return trebleBottomY - CGFloat(steps) * (lineSpacing / 2)
        } else {
            let refStep = Solfege.diatonicStep(for: bassBottomPitch)
            let steps = Solfege.diatonicStep(for: pitch) - refStep
            return bassBottomY - CGFloat(steps) * (lineSpacing / 2)
        }
    }
}

#Preview {
    StaffNotationView(arrangement: SampleArrangements.furEliseTwoHands, currentBeat: 2.0)
        .frame(height: 240)
}
