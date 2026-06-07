import Foundation

/// 演奏データの取得窓口。
///
/// 本来は「曲 × 難易度」ごとにアレンジ済みのMIDIファイルをアプリに内蔵し、
/// `MIDIFileParser` で読み込む想定。まだ全曲分のMIDIが揃っていないため、
/// 現段階では以下の優先順位でデータを返す:
///   1. 手書きのサンプルアレンジ（エリーゼのために：実際の楽曲フレーズ）
///   2. バンドル済みMIDIファイルから読み込んだデータ（MIDI読み込みのデモ用）
///   3. それも無ければ簡単な音階のフォールバック
struct SampleArrangements {

    /// 「エリーゼのために」冒頭フレーズ（超初心者向けに簡略化・右手のみ）
    static let furEliseOpening = Arrangement(
        notes: [
            PlayedNote(pitch: 76, startBeat: 0.0, duration: 0.5, hand: .right), // ミ (E5)
            PlayedNote(pitch: 75, startBeat: 0.5, duration: 0.5, hand: .right), // レ# (D#5)
            PlayedNote(pitch: 76, startBeat: 1.0, duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 75, startBeat: 1.5, duration: 0.5, hand: .right), // レ#
            PlayedNote(pitch: 76, startBeat: 2.0, duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 71, startBeat: 2.5, duration: 0.5, hand: .right), // シ (B4)
            PlayedNote(pitch: 74, startBeat: 3.0, duration: 0.5, hand: .right), // レ (D5)
            PlayedNote(pitch: 72, startBeat: 3.5, duration: 0.5, hand: .right), // ド (C5)
            PlayedNote(pitch: 69, startBeat: 4.0, duration: 1.5, hand: .right), // ラ (A4)
        ],
        bpm: 100
    )

    /// 曲が見つからない場合の最終フォールバック：ドレミファソの簡単な音階
    static let scaleFallback = Arrangement(
        notes: [
            PlayedNote(pitch: 60, startBeat: 0.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 1.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 2.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 3.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 67, startBeat: 4.0, duration: 1.5, hand: .right), // ソ
        ],
        bpm: 100
    )

    /// MIDIファイル読み込みのデモ用。`Resources/sample_melody.mid` を実際にパースして使う。
    /// （きらきら星のメロディ。専用アレンジが用意されるまでの仮データ）
    private static let midiDemoArrangement: Arrangement? =
        MIDIFileParser.loadArrangement(resourceName: "sample_melody")

    /// 曲IDと難易度から演奏データを取得する
    static func arrangement(for songID: String, difficulty: Difficulty) -> Arrangement {
        switch songID {
        case "beethoven-elise":
            return furEliseOpening
        default:
            return midiDemoArrangement ?? scaleFallback
        }
    }
}
