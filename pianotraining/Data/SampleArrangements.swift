import Foundation

/// 演奏データの取得窓口。
///
/// 「曲 × 難易度」ごとにアレンジ済みのMIDIファイルをアプリに内蔵し、`MIDIFileParser` で
/// 読み込むのが正式な方式。`Resources/` に
///   `<曲ID>-<難易度キー>.mid`  例: `beethoven-elise-beginner.mid`
/// という名前でMIDIファイルを追加すると、`arrangement(for:difficulty:)` が自動的にそれを
/// 読み込んで使用する（`Difficulty.resourceKey` が難易度キーを定義している）。
///
/// 該当するMIDIファイルがまだ無い曲・難易度については、以下の優先順位でフォールバックする:
///   1. バンドル済みMIDIファイル（命名規則に沿ったもの）から読み込んだデータ
///   2. 手書きのサンプルアレンジ（実際の楽曲フレーズを採用したプレースホルダー）
///   3. それも無ければ簡単な音階のフォールバック
struct SampleArrangements {

    // MARK: - エリーゼのために（ベートーヴェン）有名な開始テーマ（ロンド形式のA主題）

    /// 超初心者向け：右手のメロディのみ（有名なテーマの前半フレーズ）
    static let furEliseOpening = Arrangement(
        notes: [
            PlayedNote(pitch: 76, startBeat: 0.0,  duration: 0.5, hand: .right), // ミ (E5)
            PlayedNote(pitch: 75, startBeat: 0.5,  duration: 0.5, hand: .right), // レ#(D#5)
            PlayedNote(pitch: 76, startBeat: 1.0,  duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 75, startBeat: 1.5,  duration: 0.5, hand: .right), // レ#
            PlayedNote(pitch: 76, startBeat: 2.0,  duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 71, startBeat: 2.5,  duration: 0.5, hand: .right), // シ (B4)
            PlayedNote(pitch: 74, startBeat: 3.0,  duration: 0.5, hand: .right), // レ (D5)
            PlayedNote(pitch: 72, startBeat: 3.5,  duration: 0.5, hand: .right), // ド (C5)
            PlayedNote(pitch: 69, startBeat: 4.0,  duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 60, startBeat: 5.5,  duration: 0.5, hand: .right), // ド (C4)
            PlayedNote(pitch: 64, startBeat: 6.0,  duration: 0.5, hand: .right), // ミ (E4)
            PlayedNote(pitch: 69, startBeat: 6.5,  duration: 0.5, hand: .right), // ラ (A4)
            PlayedNote(pitch: 71, startBeat: 7.0,  duration: 1.0, hand: .right), // シ (B4)
            PlayedNote(pitch: 64, startBeat: 8.5,  duration: 0.5, hand: .right), // ミ (E4)
            PlayedNote(pitch: 68, startBeat: 9.0,  duration: 0.5, hand: .right), // ソ#(G#4)
            PlayedNote(pitch: 71, startBeat: 9.5,  duration: 0.5, hand: .right), // シ (B4)
            PlayedNote(pitch: 72, startBeat: 10.0, duration: 1.0, hand: .right), // ド (C5)
            PlayedNote(pitch: 64, startBeat: 11.5, duration: 0.5, hand: .right), // ミ (E4)
            PlayedNote(pitch: 76, startBeat: 12.0, duration: 0.5, hand: .right), // ミ (E5)
            PlayedNote(pitch: 75, startBeat: 12.5, duration: 0.5, hand: .right), // レ#(D#5)
            PlayedNote(pitch: 69, startBeat: 13.0, duration: 1.5, hand: .right), // ラ (A4)
        ],
        bpm: 100
    )

    /// 初心者・中級向け：有名なテーマ（前半＋後半フレーズ）の右手メロディ＋左手の伴奏
    static let furEliseTwoHands = Arrangement(
        notes: furEliseOpening.notes + [
            // テーマ後半フレーズ（前半と同じ動機から、最後は主音ラに着地して締めくくる）
            PlayedNote(pitch: 76, startBeat: 14.5, duration: 0.5, hand: .right), // ミ (E5)
            PlayedNote(pitch: 75, startBeat: 15.0, duration: 0.5, hand: .right), // レ#(D#5)
            PlayedNote(pitch: 76, startBeat: 15.5, duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 75, startBeat: 16.0, duration: 0.5, hand: .right), // レ#
            PlayedNote(pitch: 76, startBeat: 16.5, duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 71, startBeat: 17.0, duration: 0.5, hand: .right), // シ (B4)
            PlayedNote(pitch: 74, startBeat: 17.5, duration: 0.5, hand: .right), // レ (D5)
            PlayedNote(pitch: 72, startBeat: 18.0, duration: 0.5, hand: .right), // ド (C5)
            PlayedNote(pitch: 69, startBeat: 18.5, duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 60, startBeat: 20.0, duration: 0.5, hand: .right), // ド (C4)
            PlayedNote(pitch: 64, startBeat: 20.5, duration: 0.5, hand: .right), // ミ (E4)
            PlayedNote(pitch: 69, startBeat: 21.0, duration: 0.5, hand: .right), // ラ (A4)
            PlayedNote(pitch: 71, startBeat: 21.5, duration: 1.0, hand: .right), // シ (B4)
            PlayedNote(pitch: 62, startBeat: 23.0, duration: 0.5, hand: .right), // レ (D4)
            PlayedNote(pitch: 72, startBeat: 23.5, duration: 0.5, hand: .right), // ド (C5)
            PlayedNote(pitch: 71, startBeat: 24.0, duration: 0.5, hand: .right), // シ (B4)
            PlayedNote(pitch: 69, startBeat: 24.5, duration: 2.0, hand: .right), // ラ (A4)

            // 左手伴奏：テーマの和声（イ短調→ホ長調→イ短調）に沿った持続和音の簡略パターン
            PlayedNote(pitch: 45, startBeat: 0.0,  duration: 7.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 0.0,  duration: 7.0, hand: .left), // ミ (E3)
            PlayedNote(pitch: 52, startBeat: 7.0,  duration: 7.5, hand: .left), // ミ (E3)
            PlayedNote(pitch: 56, startBeat: 7.0,  duration: 7.5, hand: .left), // ソ#(G#3)
            PlayedNote(pitch: 45, startBeat: 14.5, duration: 7.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 14.5, duration: 7.0, hand: .left), // ミ (E3)
            PlayedNote(pitch: 52, startBeat: 21.5, duration: 3.0, hand: .left), // ミ (E3)
            PlayedNote(pitch: 56, startBeat: 21.5, duration: 3.0, hand: .left), // ソ#(G#3)
            PlayedNote(pitch: 45, startBeat: 24.5, duration: 2.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 24.5, duration: 2.0, hand: .left), // ミ (E3)
        ],
        bpm: 100
    )

    // MARK: - メヌエット ト長調（バッハ／ペツォールト, BWV Anh.114）第1部（8小節分のフレーズ2つ）

    /// 超初心者向け：右手のメロディのみ（前半フレーズ＋後半フレーズで主音に着地するまで）
    static let minuetGOpening = Arrangement(
        notes: [
            PlayedNote(pitch: 74, startBeat: 0.0,  duration: 1.0, hand: .right), // レ (D5)
            PlayedNote(pitch: 67, startBeat: 1.0,  duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 69, startBeat: 2.0,  duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 71, startBeat: 3.0,  duration: 1.0, hand: .right), // シ (B4)
            PlayedNote(pitch: 72, startBeat: 4.0,  duration: 1.0, hand: .right), // ド (C5)
            PlayedNote(pitch: 74, startBeat: 5.0,  duration: 1.0, hand: .right), // レ (D5)
            PlayedNote(pitch: 67, startBeat: 6.0,  duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 67, startBeat: 7.0,  duration: 2.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 71, startBeat: 9.0,  duration: 1.0, hand: .right), // シ (B4)
            PlayedNote(pitch: 69, startBeat: 10.0, duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 67, startBeat: 11.0, duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 66, startBeat: 12.0, duration: 1.0, hand: .right), // ファ#(F#4)
            PlayedNote(pitch: 67, startBeat: 13.0, duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 69, startBeat: 14.0, duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 71, startBeat: 15.0, duration: 1.0, hand: .right), // シ (B4)
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 2.0, hand: .right), // ソ (G4)
        ],
        bpm: 110
    )

    /// 初心者・中級向け：右手のメロディ（前半＋後半フレーズ）＋左手の伴奏（ト長調の持続和音）
    static let minuetGTwoHands = Arrangement(
        notes: minuetGOpening.notes + [
            PlayedNote(pitch: 43, startBeat: 0.0,  duration: 4.5, hand: .left), // ソ (G2)
            PlayedNote(pitch: 50, startBeat: 0.0,  duration: 4.5, hand: .left), // レ (D3)
            PlayedNote(pitch: 43, startBeat: 4.5,  duration: 4.5, hand: .left), // ソ (G2)
            PlayedNote(pitch: 50, startBeat: 4.5,  duration: 4.5, hand: .left), // レ (D3)
            PlayedNote(pitch: 38, startBeat: 9.0,  duration: 4.5, hand: .left), // レ (D2)
            PlayedNote(pitch: 50, startBeat: 9.0,  duration: 4.5, hand: .left), // レ (D3)
            PlayedNote(pitch: 43, startBeat: 13.5, duration: 4.5, hand: .left), // ソ (G2)
            PlayedNote(pitch: 50, startBeat: 13.5, duration: 4.5, hand: .left), // レ (D3)
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
        MIDIFileParser.loadArrangement(resourceName: "sample_melody", fallbackHand: .right)

    /// 曲ID・難易度から演奏データを取得する。
    /// `<曲ID>-<難易度キー>.mid` という名前のMIDIファイルが `Resources/` にあれば、
    /// それを最優先で読み込む（本物の楽譜にもとづくデータへの切り替え用）。
    static func arrangement(for songID: String, difficulty: Difficulty) -> Arrangement {
        if let fromFile = MIDIFileParser.loadArrangement(resourceName: "\(songID)-\(difficulty.resourceKey)") {
            return fromFile
        }

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
