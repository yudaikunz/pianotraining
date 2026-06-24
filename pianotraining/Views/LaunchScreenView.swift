import SwiftUI

/// 起動時に短く表示するスプラッシュ画面。
/// アプリの中核体験（鍵盤に向かって音符が落ちてくる練習画面）をそのまま小さく再現し、
/// 起動直後から「ピアノの練習アプリ」であることを伝える。
struct LaunchScreenView: View {
    @State private var currentBeat: Double = 0

    private let arrangement = SampleArrangements.furEliseOpening
    private let loopBeats = 8.0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.48, green: 0.47, blue: 0.92),
                    Color(red: 0.21, green: 0.20, blue: 0.54)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 36) {
                VStack(spacing: 8) {
                    Image(systemName: "pianokeys")
                        .font(.system(size: 44, weight: .medium))
                        .foregroundStyle(.white)
                    Text("ピアノ練習")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }

                GeometryReader { geo in
                    let layout = KeyboardLayout(
                        lowestPitch: 60, octaveCount: 2,
                        width: geo.size.width, keyboardHeight: 110
                    )
                    VStack(spacing: 6) {
                        FallingNotesView(
                            arrangement: arrangement,
                            currentBeat: currentBeat,
                            layout: layout,
                            lookAheadBeats: 3
                        )
                        .frame(width: layout.width, height: geo.size.height - layout.keyboardHeight - 6)

                        PianoKeyboardView(layout: layout, highlightedKeys: highlightedKeys)
                    }
                }
                .frame(height: 260)
                .padding(.horizontal, 36)
            }
        }
        .task {
            await runLoop()
        }
    }

    private var highlightedKeys: [Int: Hand] {
        var result: [Int: Hand] = [:]
        for note in arrangement.notes
        where currentBeat >= note.startBeat && currentBeat < note.startBeat + note.duration {
            result[note.pitch] = note.hand
        }
        return result
    }

    private func runLoop() async {
        let beatsPerSecond = arrangement.bpm / 60
        let startDate = Date()
        while !Task.isCancelled {
            let elapsed = Date().timeIntervalSince(startDate) * beatsPerSecond
            currentBeat = elapsed.truncatingRemainder(dividingBy: loopBeats)
            try? await Task.sleep(nanoseconds: 50_000_000)
        }
    }
}

#Preview {
    LaunchScreenView()
}
