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
    /// 1小節分の長さ（4分音符＝1拍として換算した拍数）。楽譜の小節線の表示に使う。
    /// 例: 3/4拍子なら3.0、3/8拍子なら1.5（4分音符換算で1拍半）
    let beatsPerMeasure: Double

    init(notes: [PlayedNote], bpm: Double, beatsPerMeasure: Double = 4) {
        self.notes = notes
        self.bpm = bpm
        self.beatsPerMeasure = beatsPerMeasure > 0 ? beatsPerMeasure : 4
    }

    var totalBeats: Double {
        notes.map { $0.startBeat + $0.duration }.max() ?? 0
    }

    /// 演奏にかかる実時間（秒）
    var durationSeconds: Double {
        bpm > 0 ? totalBeats / bpm * 60 : 0
    }
}

/// 演奏時間（秒）を「45秒」「1分20秒」のような表示用文字列に変換する。
enum DurationFormat {
    static func string(for seconds: Double) -> String {
        let total = Int(seconds.rounded())
        if total < 60 {
            return "\(total)秒"
        }
        let minutes = total / 60
        let remainingSeconds = total % 60
        return remainingSeconds == 0 ? "\(minutes)分" : "\(minutes)分\(remainingSeconds)秒"
    }
}

// MARK: - ドレミ表記への変換

enum Solfege {
    private static let names =     ["ド", "ド#", "レ", "レ#", "ミ", "ファ", "ファ#", "ソ", "ソ#", "ラ", "ラ#", "シ"]
    private static let baseNames = ["ド", "ド",  "レ", "レ",  "ミ", "ファ", "ファ",  "ソ", "ソ",  "ラ", "ラ",  "シ"]
    /// 各ピッチクラスの「基本となる段（ダイアトニック上の位置）」。C=0, D=1, E=2, F=3, G=4, A=5, B=6
    private static let diatonicSteps = [0, 0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6]

    /// MIDIノート番号 → ドレミ表記（シャープも含む。例: レ#）
    static func name(for pitch: Int) -> String {
        names[pitchClass(pitch)]
    }

    /// MIDIノート番号 → ドレミの基本音名（シャープを含めない。例: レ# も「レ」）
    /// 五線譜上では臨時記号(♯)を別表示するため、ラベルはこちらを使う
    static func baseName(for pitch: Int) -> String {
        baseNames[pitchClass(pitch)]
    }

    /// 黒鍵（シャープ系の音）かどうか
    static func isSharp(_ pitch: Int) -> Bool {
        [1, 3, 6, 8, 10].contains(pitchClass(pitch))
    }

    /// オクターブ番号（C4 = 中央ド を基準に 4）
    static func octave(for pitch: Int) -> Int {
        pitch / 12 - 1
    }

    /// 五線譜の段位置を計算するための「ダイアトニック段番号」（オクターブをまたいで連番）
    /// 例: C4=28, D4=29, E4=30 ... 1段=半オクターブ違うと7変わる
    static func diatonicStep(for pitch: Int) -> Int {
        let octave = pitch / 12 - 1
        return octave * 7 + diatonicSteps[pitchClass(pitch)]
    }

    private static func pitchClass(_ pitch: Int) -> Int {
        ((pitch % 12) + 12) % 12
    }
}
