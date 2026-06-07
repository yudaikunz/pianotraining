import SwiftUI

struct PracticeView: View {
    let song: Song
    let difficulty: Difficulty

    @State private var currentBeat: Double = 0
    @State private var isPlaying = false

    private var arrangement: Arrangement {
        SampleArrangements.arrangement(for: song.id, difficulty: difficulty)
    }

    private var highlightedPitches: Set<Int> {
        Set(arrangement.notes
            .filter { currentBeat >= $0.startBeat && currentBeat < $0.startBeat + $0.duration }
            .map { $0.pitch })
    }

    private var difficultyColor: Color {
        switch difficulty {
        case .superBeginner: return .green
        case .beginner:      return .blue
        case .intermediate:  return .orange
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            header

            SimplifiedScoreView(arrangement: arrangement, currentBeat: currentBeat)
                .frame(height: 100)

            PianoKeyboardView(highlightedPitches: highlightedPitches)
                .frame(height: 160)
                .padding(.horizontal)

            controls

            Spacer()
        }
        .padding(.top, 12)
        .navigationTitle("練習")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: isPlaying) {
            guard isPlaying else { return }
            let beatsPerTick = 0.05 * (arrangement.bpm / 60)
            while isPlaying && !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 50_000_000)
                currentBeat += beatsPerTick
                if currentBeat >= arrangement.totalBeats {
                    currentBeat = arrangement.totalBeats
                    isPlaying = false
                }
            }
        }
    }

    private var header: some View {
        VStack(spacing: 6) {
            Text(song.title)
                .font(.title2)
                .fontWeight(.bold)
            Text(song.composer)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(difficulty.rawValue)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .background(difficultyColor.opacity(0.15))
                .foregroundStyle(difficultyColor)
                .clipShape(Capsule())
        }
    }

    private var controls: some View {
        VStack(spacing: 12) {
            ProgressView(value: currentBeat, total: max(arrangement.totalBeats, 0.01))
                .tint(difficultyColor)
                .padding(.horizontal, 32)

            HStack(spacing: 28) {
                Button {
                    currentBeat = 0
                    isPlaying = false
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                }

                Button {
                    if currentBeat >= arrangement.totalBeats { currentBeat = 0 }
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(difficultyColor)
                }
            }
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(song: SongLibrary.songs.first(where: { $0.id == "beethoven-elise" })!, difficulty: .superBeginner)
    }
}
