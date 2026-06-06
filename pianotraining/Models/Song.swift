import Foundation

enum MusicPeriod: String, CaseIterable {
    case baroque = "バロック"
    case classical = "古典"
    case romantic = "ロマン"
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

    var starCount: Int {
        switch self {
        case .superBeginner: return 1
        case .beginner:      return 2
        case .intermediate:  return 3
        }
    }
}

struct Song: Identifiable {
    let id: String
    let title: String
    let composer: String
    let description: String
    let period: MusicPeriod
    let availableDifficulties: [Difficulty]
    let durationMinutes: Int
}
