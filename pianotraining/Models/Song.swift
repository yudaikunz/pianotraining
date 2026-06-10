import SwiftUI

enum MusicPeriod: String, CaseIterable {
    case baroque = "バロック"
    case classical = "古典"
    case romantic = "ロマン"
    case folk = "民謡・童謡"

    /// 一覧画面でのアイコン・バッジ表示に使うアクセントカラー
    var color: Color {
        switch self {
        case .baroque:   return .brown
        case .classical: return .indigo
        case .romantic:  return .pink
        case .folk:      return .green
        }
    }

    /// 一覧画面でのアイコン
    var iconName: String {
        switch self {
        case .baroque:   return "pianokeys"
        case .classical: return "music.quarternote.3"
        case .romantic:  return "music.note"
        case .folk:      return "leaf"
        }
    }
}

enum Difficulty: String, CaseIterable, Identifiable {
    case superBeginner = "超初心者"
    case beginner = "初心者"
    case intermediate = "中級"

    var id: String { rawValue }

    var detail: String {
        switch self {
        case .superBeginner: return "右手のみ・シンプルなメロディ"
        case .beginner:      return "両手・基本的な伴奏付き"
        case .intermediate:  return "原曲に近いアレンジ"
        }
    }

    /// `Resources` にバンドルするMIDIファイルの命名規則に使うキー（例: "beethoven-elise-beginner.mid"）
    var resourceKey: String {
        switch self {
        case .superBeginner: return "super-beginner"
        case .beginner:      return "beginner"
        case .intermediate:  return "intermediate"
        }
    }

    var starCount: Int {
        switch self {
        case .superBeginner: return 1
        case .beginner:      return 2
        case .intermediate:  return 3
        }
    }

    /// この難易度で「曲がどのようにアレンジされるか」を表す固定プロファイル（案A）。
    /// 難易度選択画面に表示し、選ぶ前にどんな弾き方になるかが伝わるようにする。
    var profile: DifficultyProfile {
        switch self {
        case .superBeginner:
            return DifficultyProfile(
                handInvolvement: "右手のみ",
                chordComplexity: "単音メロディ",
                keyComplexity: "黒鍵なし",
                tempoRange: "♩=70〜90",
                summary: "指のポジションを動かさずに弾けるシンプルな曲です。"
            )
        case .beginner:
            return DifficultyProfile(
                handInvolvement: "両手（伴奏つき）",
                chordComplexity: "2〜3音の和音あり",
                keyComplexity: "黒鍵が少し登場",
                tempoRange: "♩=80〜104",
                summary: "左手の伴奏が加わり、両手を合わせる練習になります。"
            )
        case .intermediate:
            return DifficultyProfile(
                handInvolvement: "両手・独立した動き",
                chordComplexity: "3〜4音の和音・重なる音",
                keyComplexity: "黒鍵を含む音階",
                tempoRange: "♩=96〜126",
                summary: "原曲に近いアレンジで、手の移動や和音にも挑戦します。"
            )
        }
    }
}

/// 難易度ごとの「曲のアレンジされ方」を表す固定プロファイル（案A：固定プロファイル方式）。
/// 実際の教則本（バイエル等）やABRSMの級別基準を参考に、
/// 「両手の関与」「和音の複雑さ」「調・黒鍵」「テンポ」の観点で各難易度の特徴を言語化したもの。
struct DifficultyProfile {
    let handInvolvement: String
    let chordComplexity: String
    let keyComplexity: String
    let tempoRange: String
    let summary: String
}

struct Song: Identifiable {
    let id: String
    let title: String
    let composer: String
    let description: String
    let period: MusicPeriod
    let availableDifficulties: [Difficulty]
}
