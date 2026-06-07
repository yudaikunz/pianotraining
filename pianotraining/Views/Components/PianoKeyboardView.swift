import SwiftUI

/// 押すべき鍵盤をハイライト表示する視覚的なピアノ鍵盤
struct PianoKeyboardView: View {
    /// 今ハイライトしたいMIDIノート番号の集合
    let highlightedPitches: Set<Int>
    /// 鍵盤の最低音（デフォルト: C4 = 中央ド）
    var lowestPitch: Int = 60
    /// 表示するオクターブ数
    var octaveCount: Int = 2

    private static let whiteOffsets = [0, 2, 4, 5, 7, 9, 11]
    private static let blackOffsets: [(offset: Int, afterWhiteOffset: Int)] =
        [(1, 0), (3, 2), (6, 5), (8, 7), (10, 9)]

    private var whiteKeyPitches: [Int] {
        var result: [Int] = []
        for octave in 0..<octaveCount {
            for offset in Self.whiteOffsets {
                result.append(lowestPitch + octave * 12 + offset)
            }
        }
        result.append(lowestPitch + octaveCount * 12) // 最後にオクターブ上のドを追加
        return result
    }

    private var blackKeys: [(pitch: Int, whiteIndexBefore: Int)] {
        var result: [(Int, Int)] = []
        for octave in 0..<octaveCount {
            for entry in Self.blackOffsets {
                let pitch = lowestPitch + octave * 12 + entry.offset
                guard let whiteIndex = Self.whiteOffsets.firstIndex(of: entry.afterWhiteOffset) else { continue }
                result.append((pitch, octave * 7 + whiteIndex))
            }
        }
        return result
    }

    var body: some View {
        GeometryReader { geo in
            let whiteKeyWidth = geo.size.width / CGFloat(whiteKeyPitches.count)
            let blackKeyWidth = whiteKeyWidth * 0.6
            let blackKeyHeight = geo.size.height * 0.6

            ZStack(alignment: .topLeading) {
                HStack(spacing: 0) {
                    ForEach(whiteKeyPitches, id: \.self) { pitch in
                        WhiteKeyView(pitch: pitch, isHighlighted: highlightedPitches.contains(pitch))
                            .frame(width: whiteKeyWidth)
                    }
                }

                ForEach(blackKeys, id: \.pitch) { key in
                    BlackKeyView(isHighlighted: highlightedPitches.contains(key.pitch))
                        .frame(width: blackKeyWidth, height: blackKeyHeight)
                        .offset(x: CGFloat(key.whiteIndexBefore + 1) * whiteKeyWidth - blackKeyWidth / 2)
                }
            }
        }
    }
}

private struct WhiteKeyView: View {
    let pitch: Int
    let isHighlighted: Bool

    var body: some View {
        VStack {
            Spacer()
            Text(Solfege.name(for: pitch))
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(isHighlighted ? Color.white : Color.secondary)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isHighlighted ? Color.accentColor : Color.white)
        .overlay(Rectangle().stroke(Color(.systemGray4), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .animation(.easeOut(duration: 0.12), value: isHighlighted)
    }
}

private struct BlackKeyView: View {
    let isHighlighted: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(isHighlighted ? Color.orange : Color.black)
            .animation(.easeOut(duration: 0.12), value: isHighlighted)
    }
}

#Preview {
    PianoKeyboardView(highlightedPitches: [60, 64, 67])
        .frame(height: 160)
        .padding()
}
