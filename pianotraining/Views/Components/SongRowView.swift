import SwiftUI

struct SongRowView: View {
    let song: Song

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            songIcon

            VStack(alignment: .leading, spacing: 6) {
                Text(song.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Text(song.composer)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(song.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                HStack(spacing: 6) {
                    PeriodBadge(period: song.period)
                    ForEach(song.availableDifficulties) { difficulty in
                        DifficultyBadge(difficulty: difficulty)
                    }
                    Spacer()
                    if let summary = SongDurations.summaryText(for: song) {
                        Label(summary, systemImage: "clock")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 2)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
        )
    }

    private var songIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [song.period.color.opacity(0.25), song.period.color.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
            Image(systemName: song.iconName)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(song.period.color.gradient)
        }
    }
}

struct PeriodBadge: View {
    let period: MusicPeriod

    var body: some View {
        Text(period.rawValue)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(period.color.opacity(0.12))
            .foregroundStyle(period.color)
            .clipShape(Capsule())
    }
}

struct DifficultyBadge: View {
    let difficulty: Difficulty

    var color: Color {
        switch difficulty {
        case .superBeginner: return .green
        case .beginner:      return .blue
        case .intermediate:  return .orange
        }
    }

    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(color.opacity(0.15))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: 12) {
        SongRowView(song: SongLibrary.songs[0])
        SongRowView(song: SongLibrary.songs[2])
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
