import SwiftUI

struct SongRowView: View {
    let song: Song

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            songIcon

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(song.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.tertiary)
                }

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
        TintedIconView(systemName: song.iconName, color: song.period.color)
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

    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption2)
            .fontWeight(.medium)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(difficulty.color.opacity(0.15))
            .foregroundStyle(difficulty.color)
            .clipShape(Capsule())
    }
}

/// グラデーション背景 + SF Symbol アイコンの組み合わせ。
/// 曲一覧、難易度選択、設定画面で共通して使うアイコンパターン。
struct TintedIconView: View {
    let systemName: String
    let color: Color
    var size: CGFloat = 50
    var iconSize: CGFloat = 20
    var cornerRadius: CGFloat = 16

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(LinearGradient(
                    colors: [color.opacity(0.25), color.opacity(0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: size, height: size)
            Image(systemName: systemName)
                .font(.system(size: iconSize, weight: .medium))
                .foregroundStyle(color.gradient)
        }
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
