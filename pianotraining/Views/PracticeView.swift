import SwiftUI

// MARK: - Practice screen (placeholder — sheet music and keyboard in next step)
struct PracticeView: View {
    let song: Song
    let difficulty: Difficulty

    var difficultyColor: Color {
        switch difficulty {
        case .superBeginner: return .green
        case .beginner:      return .blue
        case .intermediate:  return .orange
        }
    }

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "pianokeys")
                .font(.system(size: 80))
                .foregroundStyle(.secondary)

            VStack(spacing: 10) {
                Text(song.title)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(song.composer)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(difficulty.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(difficultyColor.opacity(0.15))
                    .foregroundStyle(difficultyColor)
                    .clipShape(Capsule())
            }

            VStack(spacing: 8) {
                Image(systemName: "hammer.fill")
                    .foregroundStyle(.secondary)
                Text("楽譜・鍵盤表示は次のステップで実装します")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("練習")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PracticeView(song: SongLibrary.songs[0], difficulty: .beginner)
    }
}
