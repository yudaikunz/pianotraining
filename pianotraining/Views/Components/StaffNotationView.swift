import SwiftUI

/// 簡略化した大譜表（ト音記号＝右手 / ヘ音記号＝左手）でドレミ併記の楽譜を表示する。
/// 本物の楽譜の見た目に近づけつつ、各音符の下にドレミを添えることで
/// 「楽譜の読み方」と「ドレミ」を結びつけて学べるようにする。
struct StaffNotationView: View {
    let arrangement: Arrangement

    private let lineSpacing: CGFloat = 12
    /// 1拍あたりの横幅。音符の「拍位置」をそのまま横軸に対応させることで、
    /// 同時に鳴る音符（和音・両手の合わせ）が縦に揃って見えるようにする。
    private let beatWidth: CGFloat = 34
    private let leadingPadding: CGFloat = 30
    private let noteWidth: CGFloat = 13
    private let noteHeight: CGFloat = 11

    // 各譜表の最下線にあたる音
    private let trebleBottomPitch = 64 // ホ(E4): ト音記号の最下線
    private let bassBottomPitch = 43   // ト(G2): ヘ音記号の最下線

    private var trebleTopY: CGFloat { 28 }
    private var trebleBottomY: CGFloat { trebleTopY + lineSpacing * 4 }
    private var bassTopY: CGFloat { trebleBottomY + lineSpacing * 5 }
    private var bassBottomY: CGFloat { bassTopY + lineSpacing * 4 }
    private var contentHeight: CGFloat { bassBottomY + 34 }
    private var contentWidth: CGFloat { CGFloat(arrangement.totalBeats) * beatWidth + leadingPadding + 50 }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 6) {
                clefLabels
                ZStack(alignment: .topLeading) {
                    staffLines(topY: trebleTopY)
                    staffLines(topY: bassTopY)
                    middleCGuide

                    ForEach(arrangement.notes) { note in
                        noteView(for: note, x: CGFloat(note.startBeat) * beatWidth + leadingPadding)
                    }
                }
                .frame(width: contentWidth, height: contentHeight, alignment: .topLeading)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
    }

    // MARK: - パーツ

    private var clefLabels: some View {
        VStack(spacing: 0) {
            VStack(spacing: 3) {
                Image(systemName: "music.note")
                    .font(.system(size: 16, weight: .bold))
                Text("右手")
                    .font(.caption2.bold())
            }
            .foregroundStyle(.blue)
            .frame(height: lineSpacing * 4 + lineSpacing * 2.5)

            VStack(spacing: 3) {
                Image(systemName: "music.note")
                    .font(.system(size: 16, weight: .bold))
                Text("左手")
                    .font(.caption2.bold())
            }
            .foregroundStyle(.red)
            .frame(height: lineSpacing * 4 + lineSpacing * 2.5)
        }
        .padding(.top, trebleTopY - lineSpacing * 1.2)
        .frame(width: 38)
    }

    private func staffLines(topY: CGFloat) -> some View {
        ForEach(0..<5, id: \.self) { i in
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: contentWidth, height: 1)
                .offset(y: topY + CGFloat(i) * lineSpacing)
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

    /// 1つの音符を表す要素群（符頭＋ドレミラベル）を返す。
    /// `Group` はレイアウトに影響しない透過コンテナなので、
    /// 各要素はそのまま親の ZStack（明示フレーム済み）の座標系で `.position` される。
    @ViewBuilder
    private func noteView(for note: PlayedNote, x: CGFloat) -> some View {
        let y = yPosition(for: note.pitch)
        let color: Color = note.hand == .right ? .blue : .red

        Group {
            if needsLedgerLine(for: note.pitch) {
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: noteWidth + 8, height: 1)
                    .position(x: x, y: y)
            }
            Ellipse()
                .fill(color)
                .frame(width: noteWidth, height: noteHeight)
                .position(x: x, y: y)

            if Solfege.isSharp(note.pitch) {
                Text("♯")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(color)
                    .position(x: x - (noteWidth / 2 + 9), y: y)
            }

            // ドレミラベル（符頭の少し下に表示）
            Text(Solfege.baseName(for: note.pitch))
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(color)
                .position(x: x, y: y + lineSpacing * 1.9)
        }
    }

    private func needsLedgerLine(for pitch: Int) -> Bool {
        pitch == 60 // 中央ド：ト音記号の下／ヘ音記号の上に1本だけ加線が必要な代表的な音
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
    StaffNotationView(arrangement: SampleArrangements.furEliseTwoHands)
        .frame(height: 240)
}
