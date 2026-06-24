import Foundation

/// 曲 × 難易度ごとの実際の演奏時間をキャッシュする。
///
/// `SampleArrangements.arrangement(for:difficulty:)` はMusicXML/MIDIファイルの
/// パースを伴うため、画面描画のたびに呼び出すと負荷がかかる。
/// アプリ起動時に一度だけ全曲・全難易度分を計算してキャッシュしておく。
enum SongDurations {
    private static let cache: [String: Double] = {
        var result: [String: Double] = [:]
        for song in SongLibrary.songs {
            for difficulty in song.availableDifficulties {
                let arrangement = SampleArrangements.arrangement(for: song.id, difficulty: difficulty)
                result[key(songID: song.id, difficulty: difficulty)] = arrangement.durationSeconds
            }
        }
        return result
    }()

    private static func key(songID: String, difficulty: Difficulty) -> String {
        "\(songID)-\(difficulty.rawValue)"
    }

    /// 指定した曲・難易度の演奏時間（秒）。
    static func seconds(songID: String, difficulty: Difficulty) -> Double {
        cache[key(songID: songID, difficulty: difficulty)] ?? 0
    }

    /// 曲選択画面に表示する演奏時間の目安。
    /// 難易度ごとに演奏時間が異なる場合は「最短〜最長」の範囲で表示する。
    static func summaryText(for song: Song) -> String? {
        let durations = song.availableDifficulties.map { seconds(songID: song.id, difficulty: $0) }
        guard let minDuration = durations.min(), let maxDuration = durations.max() else { return nil }

        let minText = DurationFormat.string(for: minDuration)
        let maxText = DurationFormat.string(for: maxDuration)
        return minText == maxText ? minText : "\(minText)〜\(maxText)"
    }
}
