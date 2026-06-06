import SwiftUI

struct SongRowView: View {
    let song: Song

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(song.title)
                        .font(.headline)
                    Text(song.composer)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                PeriodBadge(period: song.period)
            }

            Text(song.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            HStack(spacing: 6) {
                ForEach(song.availableDifficulties) { difficulty in
                    DifficultyBadge(difficulty: difficulty)
                }
                Spacer()
                Label("約\(song.durationMinutes)分", systemImage: "clock")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
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
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 6))
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
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
