import SwiftUI

/// 押すべき鍵盤をハイライト表示する視覚的なピアノ鍵盤
/// レイアウトは `KeyboardLayout` で計算し、FallingNotesView と横位置を一致させる
struct PianoKeyboardView: View {
    let layout: KeyboardLayout
    /// 今ハイライトしたい鍵（MIDIノート番号 → 弾く手）。
    /// 楽譜・落下ノーツと同じ手の色（右手＝青 / 左手＝赤）で光らせる
    let highlightedKeys: [Int: Hand]

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 0) {
                ForEach(layout.whiteKeyPitches, id: \.self) { pitch in
                    WhiteKeyView(pitch: pitch, highlightHand: highlightedKeys[pitch])
                        .frame(width: layout.whiteKeyWidth, height: layout.keyboardHeight)
                }
            }
            ForEach(layout.blackKeyPitches, id: \.pitch) { key in
                BlackKeyView(highlightHand: highlightedKeys[key.pitch])
                    .frame(width: layout.blackKeyWidth, height: layout.blackKeyHeight)
                    .position(x: layout.centerX(for: key.pitch), y: layout.blackKeyHeight / 2)
            }
        }
        .frame(width: layout.width, height: layout.keyboardHeight)
    }
}

private struct WhiteKeyView: View {
    let pitch: Int
    let highlightHand: Hand?

    var body: some View {
        VStack {
            Spacer()
            Text(Solfege.name(for: pitch))
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(highlightHand != nil ? Color.white : Color.secondary)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            highlightHand.map { AnyShapeStyle($0.color.gradient) } ?? AnyShapeStyle(Color.white)
        )
        .overlay(Rectangle().stroke(Color(.systemGray4), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .animation(.easeOut(duration: 0.12), value: highlightHand)
    }
}

private struct BlackKeyView: View {
    let highlightHand: Hand?

    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(
                highlightHand.map { AnyShapeStyle($0.color.gradient) } ?? AnyShapeStyle(Color.black.gradient)
            )
            .animation(.easeOut(duration: 0.12), value: highlightHand)
    }
}

#Preview {
    PianoKeyboardView(
        layout: KeyboardLayout(lowestPitch: 60, octaveCount: 2, width: 360, keyboardHeight: 150),
        highlightedKeys: [60: .left, 64: .right, 67: .right]
    )
    .padding()
}
