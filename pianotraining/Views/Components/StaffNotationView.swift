import SwiftUI

/// 大譜表（ト音記号＝右手 / ヘ音記号＝左手）でドレミ併記の楽譜を表示する。
/// 一般的な楽譜の見た目（符頭・符幹・加線・小節線・音部記号）に近づけつつ、
/// 各音符の下にドレミを添えることで「楽譜の読み方」とドレミを結びつけて学べるようにする。
struct StaffNotationView: View {
    let arrangement: Arrangement
    var currentBeat: Double = 0

    private let lineSpacing: CGFloat = 12
    /// 1拍（4分音符換算）あたりの横幅。音符の「拍位置」をそのまま横軸に対応させることで、
    /// 同時に鳴る音符（和音・両手の合わせ）が縦に揃って見えるようにする。
    private let beatWidth: CGFloat = 34
    private let leadingPadding: CGFloat = 46
    private let noteWidth: CGFloat = 13
    private let noteHeight: CGFloat = 10
    private let stemLength: CGFloat = 30

    // 各譜表の最下線にあたる音
    private let trebleBottomPitch = 64 // ホ(E4): ト音記号の最下線
    private let bassBottomPitch = 43   // ト(G2): ヘ音記号の最下線
    /// 譜表の真ん中の線（5本中3本目）の相対段位置（最下線=0、1本につき2段ずつ上がる）
    private let middleLineStep = 4

    private var trebleTopY: CGFloat { 28 }
    private var trebleBottomY: CGFloat { trebleTopY + lineSpacing * 4 }
    private var bassTopY: CGFloat { trebleBottomY + lineSpacing * 5 }
    private var bassBottomY: CGFloat { bassTopY + lineSpacing * 4 }
    private var contentHeight: CGFloat { bassBottomY + 34 }
    private var contentWidth: CGFloat { CGFloat(arrangement.totalBeats) * beatWidth + leadingPadding + 40 }

    /// 1小節分の横幅
    private var measureWidth: CGFloat { CGFloat(arrangement.beatsPerMeasure) * beatWidth }

    /// 現在の拍位置に対応するX座標（再生カーソルと自動スクロールで共用）
    private var currentBeatX: CGFloat {
        CGFloat(currentBeat) * beatWidth + leadingPadding
    }

    /// 現在の拍位置で鳴っている音符のID集合
    private var activeNoteIDs: Set<UUID> {
        Set(arrangement.notes
            .filter { currentBeat >= $0.startBeat && currentBeat < $0.startBeat + $0.duration }
            .map(\.id))
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 4) {
                    clefs
                    ZStack(alignment: .topLeading) {
                        staffLines(topY: trebleTopY)
                        staffLines(topY: bassTopY)
                        middleCGuide
                        barLines
                        playheadCursor

                        ForEach(arrangement.notes) { note in
                            noteView(
                                for: note,
                                x: CGFloat(note.startBeat) * beatWidth + leadingPadding,
                                isActive: activeNoteIDs.contains(note.id)
                            )
                        }

                        // 自動スクロールのアンカー：再生カーソルの位置に置く
                        Color.clear
                            .frame(width: 1, height: contentHeight)
                            .position(x: currentBeatX, y: contentHeight / 2)
                            .id("playhead")
                    }
                    .frame(width: contentWidth, height: contentHeight, alignment: .topLeading)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
            }
            // 再生ティックごと（50ms）に即座にスクロールし、カーソルを常に中央に保つ
            .onChange(of: currentBeat) { _ in
                proxy.scrollTo("playhead", anchor: .center)
            }
        }
    }

    // MARK: - 再生カーソル

    private var playheadCursor: some View {
        Rectangle()
            .fill(Color.orange.opacity(0.55))
            .frame(width: 2, height: bassBottomY - trebleTopY + 8)
            .position(x: currentBeatX, y: (trebleTopY + bassBottomY) / 2)
    }

    // MARK: - 音部記号（ト音記号／ヘ音記号）

    private var clefs: some View {
        VStack(spacing: 0) {
            clefGlyph("𝄞", color: .blue, label: "右手", fontSize: lineSpacing * 4.3)
                .frame(height: lineSpacing * 4 + lineSpacing * 2.5, alignment: .top)
            clefGlyph("𝄢", color: .red, label: "左手", fontSize: lineSpacing * 2.5)
                .frame(height: lineSpacing * 4 + lineSpacing * 2.5, alignment: .top)
        }
        .padding(.top, trebleTopY - lineSpacing * 1.7)
        .frame(width: 40)
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

    private func staffLines(topY: CGFloat) -> some View {
        ForEach(0..<5, id: \.self) { i in
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: contentWidth, height: 1)
                .offset(y: topY + CGFloat(i) * lineSpacing)
        }
    }

    /// 小節の区切りを示す縦線（大譜表をまたいで一本につながる）。最後の小節の後ろは終止線として太く表示する。
    private var barLines: some View {
        let measureCount = max(Int(ceil(arrangement.totalBeats / arrangement.beatsPerMeasure)), 1)
        return ForEach(0...measureCount, id: \.self) { measure in
            let isFinal = measure == measureCount
            let x = CGFloat(measure) * measureWidth + leadingPadding - beatWidth * 0.42
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: isFinal ? 2.6 : 1, height: bassBottomY - trebleTopY)
                .position(x: x, y: (trebleTopY + bassBottomY) / 2)
        }
    }

    /// 「中央ド」がト音記号とヘ音記号のちょうど間にあることを示す薄いガイド線
    private var middleCGuide: some View {
        let y = (trebleBottomY + bassTopY) / 2
        return Rectangle()
            .fill(Color(.systemGray5))
            .frame(width: contentWidth, height: 1)
            .offset(y: y)
    }

    // MARK: - 音符

    /// 1つの音符を表す要素群（加線・符幹・符頭・臨時記号・ドレミラベル）を返す。
    /// `Group` はレイアウトに影響しない透過コンテナなので、
    /// 各要素はそのまま親の ZStack（明示フレーム済み）の座標系で `.position` される。
    @ViewBuilder
    private func noteView(for note: PlayedNote, x: CGFloat, isActive: Bool) -> some View {
        let y = yPosition(for: note.pitch)
        let baseColor: Color = note.hand == .right ? .blue : .red
        let color: Color = isActive ? .orange : baseColor

        Group {
            // アクティブ音符の後ろにハロー（発光感）を追加
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

            // ドレミラベル（符頭の少し下に表示）
            Text(Solfege.baseName(for: note.pitch))
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(color)
                .position(x: x, y: y + lineSpacing * 1.9)
        }
    }

    /// 符幹（符頭から伸びる縦線）。一般的な記譜法にならい、譜表の中央線より上の音は左側に下向き、
    /// 中央線以下の音は右側に上向きに描く。
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

    /// 譜表の外側にある音符に必要な加線のY座標一覧（譜表に近い側から順）。
    /// 一般的な記譜法と同様、譜表のすぐ外側の「間（ま）」には加線を引かず、
    /// 線の位置（最下線/最上線から偶数段離れた位置）にだけ加線を引く。
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

    /// MIDIノート番号 → 五線譜上のY座標（ピッチに応じてト音記号またはヘ音記号の譜表で計算）
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
