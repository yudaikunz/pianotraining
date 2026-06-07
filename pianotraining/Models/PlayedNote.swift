import Foundation

/// 演奏する手
enum Hand: String {
    case right = "右手"
    case left = "左手"
}

/// 1つの音符（MIDIノート番号ベース）
struct PlayedNote: Identifiable, Equatable {
    let id = UUID()
    /// MIDIノート番号（60 = 中央ド / C4）
    let pitch: Int
    /// 開始タイミング（拍単位）
    let startBeat: Double
    /// 長さ（拍単位）
    let duration: Double
    let hand: Hand

    static func == (lhs: PlayedNote, rhs: PlayedNote) -> Bool {
        lhs.id == rhs.id
    }
}

/// 演奏データ（曲 × 難易度の組み合わせ1つ分）
struct Arrangement {
    let notes: [PlayedNote]
    /// テンポ（1分間の拍数）
    let bpm: Double

    var totalBeats: Double {
        notes.map { $0.startBeat + $0.duration }.max() ?? 0
    }
}

// MARK: - ドレミ表記への変換

enum Solfege {
    /// MIDIノート番号 → ドレミ表記（オクターブ無視）
    static func name(for pitch: Int) -> String {
        let names = ["ド", "ド#", "レ", "レ#", "ミ", "ファ", "ファ#", "ソ", "ソ#", "ラ", "ラ#", "シ"]
        return names[((pitch % 12) + 12) % 12]
    }

    /// 黒鍵（シャープ系の音）かどうか
    static func isSharp(_ pitch: Int) -> Bool {
        [1, 3, 6, 8, 10].contains(((pitch % 12) + 12) % 12)
    }

    /// オクターブ番号（C4 = 中央ド を基準に 4）
    static func octave(for pitch: Int) -> Int {
        pitch / 12 - 1
    }
}
