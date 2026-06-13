import SwiftUI

/// 設定画面でユーザーが変更できるアプリ全体の設定。
/// 値は UserDefaults（@AppStorage と同じストア）に保存され、アプリを再起動しても保持される。
/// ここでは「キー」と「保存値の読み出し」だけを定義し、書き込みは各画面の @AppStorage が行う。
enum AppSettings {
    static let themeKey = "settings.theme"
    static let rightHandColorKey = "settings.rightHandColor"
    static let leftHandColorKey = "settings.leftHandColor"
    static let playbackSpeedKey = "settings.playbackSpeed"

    /// 再生スピード（テンポ倍率）の選択肢。
    /// 難所をゆっくりさらいたい／少しだけ速くしたい、どちらにも対応できるよう細かく刻む。
    static let playbackSpeedOptions: [Double] = [
        0.25, 0.4, 0.5, 0.6, 0.7, 0.75, 0.8, 0.9,
        1.0,
        1.1, 1.25, 1.4, 1.5, 1.75, 2.0
    ]

    /// 右手パートの表示色（楽譜・落下ノーツ・鍵盤ハイライト共通）
    static var rightHandColor: HandColorOption {
        option(forKey: rightHandColorKey) ?? .blue
    }

    /// 左手パートの表示色（楽譜・落下ノーツ・鍵盤ハイライト共通）
    static var leftHandColor: HandColorOption {
        option(forKey: leftHandColorKey) ?? .red
    }

    /// 「×0.75」のような再生スピードの表示用文字列
    static func speedText(_ speed: Double) -> String {
        "×" + String(format: "%g", speed)
    }

    private static func option(forKey key: String) -> HandColorOption? {
        guard let rawValue = UserDefaults.standard.string(forKey: key) else { return nil }
        return HandColorOption(rawValue: rawValue)
    }
}

/// カラーテーマ（システム準拠 / ライト固定 / ダーク固定）
enum ThemeOption: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var label: String {
        switch self {
        case .system: return "システムに合わせる"
        case .light:  return "ライト"
        case .dark:   return "ダーク"
        }
    }

    /// `.preferredColorScheme()` に渡す値（nil＝システム準拠）
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}

/// 手の表示色の選択肢。
/// 再生中の音符のハイライト（オレンジ）と紛らわしくならないよう、オレンジ系は含めない。
enum HandColorOption: String, CaseIterable, Identifiable {
    case blue
    case red
    case green
    case purple
    case pink
    case teal

    var id: String { rawValue }

    var label: String {
        switch self {
        case .blue:   return "青"
        case .red:    return "赤"
        case .green:  return "緑"
        case .purple: return "紫"
        case .pink:   return "ピンク"
        case .teal:   return "水色"
        }
    }

    var color: Color {
        switch self {
        case .blue:   return .blue
        case .red:    return .red
        case .green:  return .green
        case .purple: return .purple
        case .pink:   return .pink
        case .teal:   return .teal
        }
    }
}
