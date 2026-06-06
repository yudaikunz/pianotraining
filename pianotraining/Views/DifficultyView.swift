import SwiftUI

struct DifficultyView: View {
    let song: Song

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                songInfoCard

                VStack(alignment: .leading, spacing: 12) {
                    Text("難易度を選ぶ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ForEach(song.availableDifficulties) { difficulty in
                        NavigationLink(destination: PracticeView(song: song, difficulty: difficulty)) {
                            DifficultyCard(difficulty: difficulty)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(song.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var songInfoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(song.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(song.composer)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "pianokeys")
                    .font(.system(size: 36))
                    .foregroundStyle(.secondary)
            }

            Divider()

            Text(song.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Label(song.period.rawValue, systemImage: "music.note")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Label("約\(song.durationMinutes)分", systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

struct DifficultyCard: View {
    let difficulty: Difficulty

    var color: Color {
        switch difficulty {
        case .superBeginner: return .green
        case .beginner:      return .blue
        case .intermediate:  return .orange
        }
    }

    var iconName: String {
        switch difficulty {
        case .superBeginner: return "1.circle.fill"
        case .beginner:      return "2.circle.fill"
        case .intermediate:  return "3.circle.fill"
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: iconName)
                    .font(.system(size: 26))
                    .foregroundStyle(color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(difficulty.rawValue)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(difficulty.detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 3) {
                ForEach(0..<3) { i in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(i < difficulty.starCount ? color : Color(.systemGray4))
                }
            }

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color(.systemGray3))
        }
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(color.opacity(0.25), lineWidth: 1)
        )
    }
}

#Preview {
    NavigationStack {
        DifficultyView(song: SongLibrary.songs[0])
    }
}
