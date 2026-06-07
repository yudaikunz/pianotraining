import SwiftUI

/// 押すべき鍵盤をハイライト表示する視覚的なピアノ鍵盤
/// レイアウトは `KeyboardLayout` で計算し、FallingNotesView と横位置を一致させる
struct PianoKeyboardView: View {
    let layout: KeyboardLayout
    /// 今ハイライトしたいMIDIノート番号の集合
    let highlightedPitches: Set<Int>

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 0) {
                ForEach(layout.whiteKeyPitches, id: \.self) { pitch in
                    WhiteKeyView(pitch: pitch, isHighlighted: highlightedPitches.contains(pitch))
                        .frame(width: layout.whiteKeyWidth, height: layout.keyboardHeight)
                }
            }
            ForEach(layout.blackKeyPitches, id: \.pitch) { key in
                BlackKeyView(isHighlighted: highlightedPitches.contains(key.pitch))
                    .frame(width: layout.blackKeyWidth, height: layout.blackKeyHeight)
                    .position(x: layout.centerX(for: key.pitch), y: layout.blackKeyHeight / 2)
            }
        }
        .frame(width: layout.width, height: layout.keyboardHeight)
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
    PianoKeyboardView(
        layout: KeyboardLayout(lowestPitch: 60, octaveCount: 2, width: 360, keyboardHeight: 150),
        highlightedPitches: [60, 64, 67]
    )
    .padding()
}
