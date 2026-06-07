import Foundation

/// 演奏データの取得窓口。
///
/// 本来は「曲 × 難易度」ごとにアレンジ済みのMIDIファイルをアプリに内蔵し、
/// `MIDIFileParser` で読み込む想定。まだ全曲分のMIDIが揃っていないため、
/// 現段階では以下の優先順位でデータを返す:
///   1. 手書きのサンプルアレンジ（実際の楽曲フレーズを採用）
///   2. バンドル済みMIDIファイルから読み込んだデータ（MIDI読み込みのデモ用）
///   3. それも無ければ簡単な音階のフォールバック
struct SampleArrangements {

    // MARK: - エリーゼのために（ベートーヴェン）冒頭フレーズ

    /// 超初心者向け：右手のメロディのみ
    static let furEliseOpening = Arrangement(
        notes: [
            PlayedNote(pitch: 76, startBeat: 0.0, duration: 0.5, hand: .right), // ミ (E5)
            PlayedNote(pitch: 75, startBeat: 0.5, duration: 0.5, hand: .right), // レ#(D#5)
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

    /// 初心者・中級向け：右手のメロディ＋左手の伴奏（簡略化した持続和音）
    static let furEliseTwoHands = Arrangement(
        notes: furEliseOpening.notes + [
            PlayedNote(pitch: 45, startBeat: 0.0, duration: 2.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 0.0, duration: 2.0, hand: .left), // ミ (E3)
            PlayedNote(pitch: 45, startBeat: 2.0, duration: 2.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 2.0, duration: 2.0, hand: .left), // ミ (E3)
            PlayedNote(pitch: 45, startBeat: 4.0, duration: 1.5, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 4.0, duration: 1.5, hand: .left), // ミ (E3)
        ],
        bpm: 100
    )

    // MARK: - メヌエット ト長調（バッハ／ペツォールト, BWV Anh.114）冒頭フレーズ

    /// 超初心者向け：右手のメロディのみ
    static let minuetGOpening = Arrangement(
        notes: [
            PlayedNote(pitch: 74, startBeat: 0.0, duration: 1.0, hand: .right), // レ (D5)
            PlayedNote(pitch: 67, startBeat: 1.0, duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 69, startBeat: 2.0, duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 71, startBeat: 3.0, duration: 1.0, hand: .right), // シ (B4)
            PlayedNote(pitch: 72, startBeat: 4.0, duration: 1.0, hand: .right), // ド (C5)
            PlayedNote(pitch: 74, startBeat: 5.0, duration: 1.0, hand: .right), // レ (D5)
            PlayedNote(pitch: 67, startBeat: 6.0, duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 67, startBeat: 7.0, duration: 2.0, hand: .right), // ソ (G4)
        ],
        bpm: 110
    )

    /// 初心者・中級向け：右手のメロディ＋左手の伴奏（ト長調の持続和音）
    static let minuetGTwoHands = Arrangement(
        notes: minuetGOpening.notes + [
            PlayedNote(pitch: 43, startBeat: 0.0, duration: 4.5, hand: .left), // ソ (G2)
            PlayedNote(pitch: 50, startBeat: 0.0, duration: 4.5, hand: .left), // レ (D3)
            PlayedNote(pitch: 43, startBeat: 4.5, duration: 4.5, hand: .left), // ソ (G2)
            PlayedNote(pitch: 50, startBeat: 4.5, duration: 4.5, hand: .left), // レ (D3)
        ],
        bpm: 110
    )

    // MARK: - フォールバック

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

    /// 曲ID・難易度から演奏データを取得する
    static func arrangement(for songID: String, difficulty: Difficulty) -> Arrangement {
        switch (songID, difficulty) {
        case ("beethoven-elise", .superBeginner):
            return furEliseOpening
        case ("beethoven-elise", _):
            return furEliseTwoHands

        case ("bach-minuet-g", .superBeginner):
            return minuetGOpening
        case ("bach-minuet-g", _):
            return minuetGTwoHands

        default:
            return midiDemoArrangement ?? scaleFallback
        }
    }
}
