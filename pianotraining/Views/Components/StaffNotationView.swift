import SwiftUI

/// 大譜表（ト音記号＝右手 / ヘ音記号＝左手）でドレミ併記の楽譜を表示する。
/// FallingNotesView と同様に currentBeat から直接座標を計算する方式を採用し、
/// ScrollView は使わない。現在の拍位置が常に中央のカーソル線と一致する。
struct StaffNotationView: View {
    let arrangement: Arrangement
    var currentBeat: Double = 0

    private let lineSpacing: CGFloat = 12
    /// 1拍あたりの横幅。FallingNotesView は縦方向に同じ比率を使う。
    private let beatWidth: CGFloat = 34
    private let noteWidth: CGFloat = 13
    private let noteHeight: CGFloat = 10
    private let stemLength: CGFloat = 30
    /// 音部記号列の幅（左端に固定表示）
    private let clefAreaWidth: CGFloat = 56

    private let trebleBottomPitch = 64 // E4: ト音記号の最下線
    private let bassBottomPitch = 43   // G2: ヘ音記号の最下線
    private let middleLineStep = 4

    private var trebleTopY: CGFloat { 16 }
    private var trebleBottomY: CGFloat { trebleTopY + lineSpacing * 4 }
    private var bassTopY: CGFloat { trebleBottomY + lineSpacing * 5 }
    private var bassBottomY: CGFloat { bassTopY + lineSpacing * 4 }
    private var contentHeight: CGFloat { bassBottomY + 30 }

    private var activeNoteIDs: Set<UUID> {
        Set(arrangement.notes
            .filter { currentBeat >= $0.startBeat && currentBeat < $0.startBeat + $0.duration }
            .map(\.id))
    }

    var body: some View {
        GeometryReader { geo in
            let notesAreaWidth = max(geo.size.width - clefAreaWidth, 100)
            // 再生カーソルは常にノートエリアの中央に固定
            let centerX = notesAreaWidth / 2

            HStack(spacing: 0) {
                // 音部記号：スクロールせず左端に固定
                clefs
                    .frame(width: clefAreaWidth, height: contentHeight)
                    .background(Color(.systemBackground))
                    .zIndex(1)

                // 音符・五線：currentBeat 基準で位置を計算し .clipped() で切り抜く
                ZStack(alignment: .topLeading) {
                    staffLines(topY: trebleTopY, width: notesAreaWidth)
                    staffLines(topY: bassTopY, width: notesAreaWidth)
                    middleCGuide(width: notesAreaWidth)
                    barLines(centerX: centerX, areaWidth: notesAreaWidth)

                    ForEach(visibleNotes(centerX: centerX, areaWidth: notesAreaWidth)) { note in
                        let x = CGFloat(note.startBeat - currentBeat) * beatWidth + centerX
                        noteView(for: note, x: x, isActive: activeNoteIDs.contains(note.id))
                    }

                    playheadCursor(at: centerX)
                }
                .frame(width: notesAreaWidth, height: contentHeight)
                .clipped()
            }
        }
    }

    // MARK: - 再生カーソル（常に中央に固定）

    private func playheadCursor(at x: CGFloat) -> some View {
        Rectangle()
            .fill(Color.orange.opacity(0.55))
            .frame(width: 2, height: bassBottomY - trebleTopY + 8)
            .position(x: x, y: (trebleTopY + bassBottomY) / 2)
    }

    // MARK: - 音部記号

    private var clefs: some View {
        VStack(spacing: 0) {
            clefGlyph("𝄞", color: .blue, label: "右手", fontSize: lineSpacing * 4.3)
                .frame(height: lineSpacing * 4 + lineSpacing * 2.5, alignment: .top)
            clefGlyph("𝄢", color: .red, label: "左手", fontSize: lineSpacing * 2.5)
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
                .font(.system(size: 9, weight: .semibold))
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

    /// 小節線：各小節の拍位置を currentBeat との差から x 座標を計算して描く。
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

    /// 画面内（± noteWidth のバッファ付き）に入っている音符だけを描画する。
    private func visibleNotes(centerX: CGFloat, areaWidth: CGFloat) -> [PlayedNote] {
        arrangement.notes.filter { note in
            let x = CGFloat(note.startBeat - currentBeat) * beatWidth + centerX
            return x > -noteWidth * 3 && x < areaWidth + noteWidth * 3
        }
    }

    @ViewBuilder
    private func noteView(for note: PlayedNote, x: CGFloat, isActive: Bool) -> some View {
        let y = yPosition(for: note.pitch)
        let baseColor: Color = note.hand == .right ? .blue : .red
        let color: Color = isActive ? .orange : baseColor

        Group {
            if isActive {
                Circle()
                    .fill(Color.orange.opacity(0.18))
                    .frame(width: 22, height: 22)
                    .position(x: x, y: y)
            }

            ForEach(ledgerLineYs(for: note.pitch), id: \.self) { ledgerY in
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: noteWidth + 8, height: 1)
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
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(color)
                    .position(x: x - (noteWidth / 2 + 10), y: y)
            }

            Text(Solfege.baseName(for: note.pitch))
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(color)
                .position(x: x, y: y + lineSpacing * 1.9)
        }
    }

    private func stem(for note: PlayedNote, x: CGFloat, y: CGFloat, color: Color) -> some View {
        let bottomPitch = note.pitch >= 60 ? trebleBottomPitch : bassBottomPitch
        let relativeStep = Solfege.diatonicStep(for: note.pitch) - Solfege.diatonicStep(for: bottomPitch)
        let pointsUp = relativeStep < middleLineStep
        let stemX = x + (pointsUp ? (noteWidth / 2 - 1) : -(noteWidth / 2 - 1))
        let centerY = pointsUp ? y - stemLength / 2 : y + stemLength / 2

        return Rectangle()
            .fill(color)
            .frame(width: 1.3, height: stemLength)
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
