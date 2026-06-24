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

                    if song.availableDifficulties.isEmpty {
                        Text("この曲は現在準備中です")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 32)
                    } else {
                        ForEach(song.availableDifficulties) { difficulty in
                            NavigationLink(destination: PracticeView(song: song, difficulty: difficulty)) {
                                DifficultyCard(
                                    difficulty: difficulty,
                                    durationSeconds: SongDurations.seconds(songID: song.id, difficulty: difficulty)
                                )
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal)
                            .carouselTiltEffect()
                        }
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
                TintedIconView(systemName: song.iconName, color: song.period.color, size: 52, iconSize: 24)
            }

            Divider()

            Text(song.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                PeriodBadge(period: song.period)
                Spacer()
                if let summary = SongDurations.summaryText(for: song) {
                    Label(summary, systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
        )
        .padding(.horizontal)
    }
}

struct DifficultyCard: View {
    let difficulty: Difficulty
    let durationSeconds: Double

    var iconName: String {
        switch difficulty {
        case .superBeginner: return "1.circle.fill"
        case .beginner:      return "2.circle.fill"
        case .intermediate:  return "3.circle.fill"
        }
    }

    private var profile: DifficultyProfile { difficulty.profile }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [difficulty.color.opacity(0.25), difficulty.color.opacity(0.08)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 52, height: 52)
                    Image(systemName: iconName)
                        .font(.system(size: 26))
                        .foregroundStyle(difficulty.color.gradient)
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

                VStack(alignment: .trailing, spacing: 6) {
                    HStack(spacing: 3) {
                        ForEach(0..<3) { i in
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundStyle(i < difficulty.starCount ? difficulty.color : Color(.systemGray4))
                        }
                    }
                    Label(DurationFormat.string(for: durationSeconds), systemImage: "clock")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray3))
            }

            profileBadges

            Text(profile.summary)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: difficulty.color.opacity(0.10), radius: 8, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(difficulty.color.opacity(0.25), lineWidth: 1)
        )
    }

    private var profileBadges: some View {
        HStack(spacing: 6) {
            badge(profile.handInvolvement)
            badge(profile.chordComplexity)
            badge(profile.keyComplexity)
            badge(profile.tempoRange)
        }
    }

    private func badge(_ text: String) -> some View {
        Text(text)
            .font(.caption2)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(difficulty.color.opacity(0.1))
            .foregroundStyle(difficulty.color)
            .clipShape(Capsule())
    }
}

#Preview {
    NavigationStack {
        DifficultyView(song: SongLibrary.songs[0])
    }
}
