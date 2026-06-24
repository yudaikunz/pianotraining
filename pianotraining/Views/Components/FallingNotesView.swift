import SwiftUI

/// 鍵盤に向かって音符が落ちてくる「ウォーターフォール式」表示。
/// 右手＝青、左手＝赤で色分けし、横位置は鍵盤の鍵の位置とぴったり揃える。
struct FallingNotesView: View {
    let arrangement: Arrangement
    let currentBeat: Double
    let layout: KeyboardLayout
    /// 何拍分先まで表示するか（大きいほど早めに音符が見える）
    var lookAheadBeats: Double = 4

    var body: some View {
        GeometryReader { geo in
            let pixelsPerBeat = geo.size.height / lookAheadBeats

            ZStack(alignment: .topLeading) {
                ForEach(visibleNotes) { note in
                    noteBlock(for: note, pixelsPerBeat: pixelsPerBeat, areaHeight: geo.size.height)
                }

                // ヒットライン（このラインに到達したタイミングで弾く）
                Rectangle()
                    .fill(Color.primary.opacity(0.3))
                    .frame(width: geo.size.width, height: 2)
                    .position(x: geo.size.width / 2, y: geo.size.height - 1)
            }
        }
        .clipped()
    }

    private func noteBlock(for note: PlayedNote, pixelsPerBeat: CGFloat, areaHeight: CGFloat) -> some View {
        let timeUntilStart = note.startBeat - currentBeat
        let blockHeight = max(CGFloat(note.duration) * pixelsPerBeat - 3, 10)
        let bottomY = areaHeight - CGFloat(timeUntilStart) * pixelsPerBeat
        let centerY = bottomY - blockHeight / 2
        let centerX = layout.centerX(for: note.pitch)
        let width = layout.isWhiteKey(note.pitch) ? layout.whiteKeyWidth - 6 : layout.blackKeyWidth - 2
        let color = note.hand.color

        return RoundedRectangle(cornerRadius: 5)
            .fill(color.gradient)
            .frame(width: width, height: blockHeight)
            .overlay(
                Text(Solfege.name(for: note.pitch))
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .padding(.horizontal, 2)
            )
            .position(x: centerX, y: centerY)
    }

    private var visibleNotes: [PlayedNote] {
        arrangement.notes.filter { note in
            let timeUntilStart = note.startBeat - currentBeat
            let timeUntilEnd = note.startBeat + note.duration - currentBeat
            return timeUntilStart < lookAheadBeats && timeUntilEnd > -0.3
        }
    }
}

#Preview {
    let layout = KeyboardLayout(lowestPitch: 60, octaveCount: 2, width: 360, keyboardHeight: 150)
    VStack(spacing: 4) {
        FallingNotesView(arrangement: SampleArrangements.furEliseOpening, currentBeat: 1.2, layout: layout)
            .frame(height: 220)
        PianoKeyboardView(layout: layout, highlightedKeys: [76: .right])
    }
    .padding()
}
