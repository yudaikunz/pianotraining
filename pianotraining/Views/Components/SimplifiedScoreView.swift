import SwiftUI

/// ドレミ表記つきの簡略楽譜（音符カードを時系列に並べたもの）
struct SimplifiedScoreView: View {
    let arrangement: Arrangement
    let currentBeat: Double

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(arrangement.notes) { note in
                        NoteCard(note: note, isActive: isActive(note))
                            .id(note.id)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            .onChange(of: currentBeat) { _, _ in
                guard let active = arrangement.notes.first(where: isActive) else { return }
                withAnimation(.easeOut(duration: 0.2)) {
                    proxy.scrollTo(active.id, anchor: .center)
                }
            }
        }
    }

    private func isActive(_ note: PlayedNote) -> Bool {
        currentBeat >= note.startBeat && currentBeat < note.startBeat + note.duration
    }
}

private struct NoteCard: View {
    let note: PlayedNote
    let isActive: Bool

    private var color: Color {
        note.hand == .right ? .blue : .purple
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(Solfege.name(for: note.pitch))
                .font(.title3)
                .fontWeight(.bold)
            Text(note.hand.rawValue)
                .font(.caption2)
        }
        .foregroundStyle(isActive ? Color.white : color)
        .frame(width: max(56, CGFloat(note.duration) * 56), height: 68)
        .background(isActive ? color : color.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(color, lineWidth: isActive ? 0 : 1.5)
        )
        .scaleEffect(isActive ? 1.08 : 1.0)
        .animation(.easeOut(duration: 0.15), value: isActive)
    }
}

#Preview {
    SimplifiedScoreView(arrangement: SampleArrangements.furEliseOpening, currentBeat: 0.6)
        .frame(height: 100)
}
