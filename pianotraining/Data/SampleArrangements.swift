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

    // MARK: - エリーゼのために（ベートーヴェン）有名な開始テーマ（ロンド形式のA-B主題）

    /// 超初心者向け：右手のメロディのみ（有名なテーマのA-Bフレーズ全体）。
    /// 両手版（`furEliseTwoHands`）と同じ長さ（拍数）にすることで、
    /// 難易度による演奏時間の差を抑える。
    static let furEliseOpening = Arrangement(
        notes: [
            // Aフレーズ
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
            // Bフレーズ（Aと同じ動機から、最後は主音ラに着地して締めくくる）
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
        ],
        bpm: 100
    )

    /// 初心者向け：右手メロディ（A-Bフレーズ）＋左手の伴奏。
    /// 超初心者と同じ有名テーマ・同じテンポ（bpm 100）で、左手の伴奏だけが加わる。
    /// 中級は本物の全曲楽譜（`beethoven-elise-intermediate.mxl`）を使う。
    static let furEliseTwoHands = Arrangement(
        notes: furEliseOpening.notes + [
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

    // MARK: - 喜びの歌（ベートーヴェン 交響曲第9番より）ハ長調・8小節

    /// 超初心者：右手のメロディのみ（白鍵のみ、ハ長調）
    static let odeToJoy = Arrangement(
        notes: [
            PlayedNote(pitch: 64, startBeat: 0.0,  duration: 1.0, hand: .right), // ミ (E4)
            PlayedNote(pitch: 64, startBeat: 1.0,  duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 2.0,  duration: 1.0, hand: .right), // ファ (F4)
            PlayedNote(pitch: 67, startBeat: 3.0,  duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 67, startBeat: 4.0,  duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 65, startBeat: 5.0,  duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 6.0,  duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 7.0,  duration: 1.0, hand: .right), // レ (D4)
            PlayedNote(pitch: 60, startBeat: 8.0,  duration: 1.0, hand: .right), // ド (C4)
            PlayedNote(pitch: 60, startBeat: 9.0,  duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 10.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 11.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 12.0, duration: 1.5, hand: .right), // ミ（付点4分）
            PlayedNote(pitch: 62, startBeat: 13.5, duration: 0.5, hand: .right), // レ（8分）
            PlayedNote(pitch: 62, startBeat: 14.0, duration: 2.0, hand: .right), // レ（2分）
            PlayedNote(pitch: 64, startBeat: 16.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 17.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 18.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 67, startBeat: 19.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 20.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 65, startBeat: 21.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 22.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 23.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 24.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 60, startBeat: 25.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 26.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 27.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 28.0, duration: 1.5, hand: .right), // レ（付点4分）
            PlayedNote(pitch: 60, startBeat: 29.5, duration: 0.5, hand: .right), // ド（8分）
            PlayedNote(pitch: 60, startBeat: 30.0, duration: 2.0, hand: .right), // ド（2分）
        ],
        bpm: 96
    )

    /// 初心者：両手版（メロディ＋左手バスライン）
    static let odeToJoyTwoHands = Arrangement(
        notes: odeToJoy.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 28.0, duration: 4.0, hand: .left), // ソ (G2)
        ],
        bpm: 96
    )

    // MARK: - きらきら星（Twinkle Twinkle Little Star）ハ長調・12小節

    /// 超初心者：右手メロディのみ
    static let twinkleStar = Arrangement(
        notes: [
            // C C G G A A G(2)
            PlayedNote(pitch: 60, startBeat: 0.0,  duration: 1.0, hand: .right), // ド (C4)
            PlayedNote(pitch: 60, startBeat: 1.0,  duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 67, startBeat: 2.0,  duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 67, startBeat: 3.0,  duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 69, startBeat: 4.0,  duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 69, startBeat: 5.0,  duration: 1.0, hand: .right), // ラ
            PlayedNote(pitch: 67, startBeat: 6.0,  duration: 2.0, hand: .right), // ソ（2拍）
            // F F E E D D C(2)
            PlayedNote(pitch: 65, startBeat: 8.0,  duration: 1.0, hand: .right), // ファ (F4)
            PlayedNote(pitch: 65, startBeat: 9.0,  duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 10.0, duration: 1.0, hand: .right), // ミ (E4)
            PlayedNote(pitch: 64, startBeat: 11.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 12.0, duration: 1.0, hand: .right), // レ (D4)
            PlayedNote(pitch: 62, startBeat: 13.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 14.0, duration: 2.0, hand: .right), // ド（2拍）
            // G G F F E E D(2)
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 17.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 65, startBeat: 18.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 65, startBeat: 19.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 20.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 21.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 22.0, duration: 2.0, hand: .right), // レ（2拍）
            // G G F F E E D(2)
            PlayedNote(pitch: 67, startBeat: 24.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 25.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 65, startBeat: 26.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 65, startBeat: 27.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 28.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 29.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 30.0, duration: 2.0, hand: .right), // レ（2拍）
            // C C G G A A G(2)
            PlayedNote(pitch: 60, startBeat: 32.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 60, startBeat: 33.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 67, startBeat: 34.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 35.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 69, startBeat: 36.0, duration: 1.0, hand: .right), // ラ
            PlayedNote(pitch: 69, startBeat: 37.0, duration: 1.0, hand: .right), // ラ
            PlayedNote(pitch: 67, startBeat: 38.0, duration: 2.0, hand: .right), // ソ（2拍）
            // F F E E D D C(2)
            PlayedNote(pitch: 65, startBeat: 40.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 65, startBeat: 41.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 42.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 43.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 44.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 62, startBeat: 45.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 46.0, duration: 2.0, hand: .right), // ド（2拍）
        ],
        bpm: 100
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let twinkleStarTwoHands = Arrangement(
        notes: twinkleStar.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 53, startBeat: 8.0,  duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 16.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 28.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 32.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 36.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 53, startBeat: 40.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 44.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 100
    )

    // MARK: - かえるのうた（カエルの合唱）ハ長調・8小節

    /// 超初心者：右手メロディのみ
    static let frogSong = Arrangement(
        notes: [
            // フレーズ1: C D E F E D C(2)
            PlayedNote(pitch: 60, startBeat: 0.0,  duration: 1.0, hand: .right), // ド (C4)
            PlayedNote(pitch: 62, startBeat: 1.0,  duration: 1.0, hand: .right), // レ (D4)
            PlayedNote(pitch: 64, startBeat: 2.0,  duration: 1.0, hand: .right), // ミ (E4)
            PlayedNote(pitch: 65, startBeat: 3.0,  duration: 1.0, hand: .right), // ファ (F4)
            PlayedNote(pitch: 64, startBeat: 4.0,  duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 5.0,  duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 6.0,  duration: 2.0, hand: .right), // ド（2拍）
            // フレーズ2: E F G A G F E(2)
            PlayedNote(pitch: 64, startBeat: 8.0,  duration: 1.0, hand: .right), // ミ (E4)
            PlayedNote(pitch: 65, startBeat: 9.0,  duration: 1.0, hand: .right), // ファ (F4)
            PlayedNote(pitch: 67, startBeat: 10.0, duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 69, startBeat: 11.0, duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 65, startBeat: 13.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 64, startBeat: 14.0, duration: 2.0, hand: .right), // ミ（2拍）
            // フレーズ3「ぐわっ ぐわっ ぐわっ ぐわっ」：ド ド ド ド（4分音符・各小節2回）
            PlayedNote(pitch: 60, startBeat: 16.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 60, startBeat: 18.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 60, startBeat: 20.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 60, startBeat: 22.0, duration: 1.0, hand: .right), // ド
            // フレーズ4「げろげろげろげろ」：ド ド レ レ ミ ミ ファ ファ（8分音符で順次上行）
            PlayedNote(pitch: 60, startBeat: 24.0, duration: 0.5, hand: .right), // ド
            PlayedNote(pitch: 60, startBeat: 24.5, duration: 0.5, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 25.0, duration: 0.5, hand: .right), // レ
            PlayedNote(pitch: 62, startBeat: 25.5, duration: 0.5, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 26.0, duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 26.5, duration: 0.5, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 27.0, duration: 0.5, hand: .right), // ファ
            PlayedNote(pitch: 65, startBeat: 27.5, duration: 0.5, hand: .right), // ファ
            // 「ぐわっ ぐわっ ぐわっ」：ミ レ ド で締めくくる
            PlayedNote(pitch: 64, startBeat: 28.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 29.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 30.0, duration: 2.0, hand: .right), // ド（2拍）
        ],
        bpm: 100
    )

    /// 初心者：両手版
    static let frogSongTwoHands = Arrangement(
        notes: frogSong.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 4.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 20.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 100
    )

    // MARK: - チューリップ ハ長調・3フレーズ（さいた／ならんだ／どのはな）12小節

    /// 超初心者：右手メロディのみ
    static let tulip = Arrangement(
        notes: [
            // セクションA「さいた さいた チューリップの はなが」（最後はレに着地）
            PlayedNote(pitch: 60, startBeat: 0.0,  duration: 1.0, hand: .right), // ド (C4)
            PlayedNote(pitch: 62, startBeat: 1.0,  duration: 1.0, hand: .right), // レ (D4)
            PlayedNote(pitch: 64, startBeat: 2.0,  duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 60, startBeat: 4.0,  duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 5.0,  duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 6.0,  duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 67, startBeat: 8.0,  duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 64, startBeat: 9.0,  duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 10.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 11.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 12.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 13.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 14.0, duration: 2.0, hand: .right), // レ（2拍）
            // セクションA'「ならんだ ならんだ あか しろ きいろ」（最後はドに着地）
            PlayedNote(pitch: 60, startBeat: 16.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 17.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 18.0, duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 60, startBeat: 20.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 21.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 22.0, duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 67, startBeat: 24.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 64, startBeat: 25.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 26.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 27.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 62, startBeat: 28.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 29.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 60, startBeat: 30.0, duration: 2.0, hand: .right), // ド（2拍）
            // セクションB「どの はな みても きれい だ な」（クライマックス・最後に登場）
            PlayedNote(pitch: 67, startBeat: 32.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 33.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 64, startBeat: 34.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 67, startBeat: 35.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 69, startBeat: 36.0, duration: 1.0, hand: .right), // ラ (A4)
            PlayedNote(pitch: 69, startBeat: 37.0, duration: 1.0, hand: .right), // ラ
            PlayedNote(pitch: 67, startBeat: 38.0, duration: 2.0, hand: .right), // ソ（2拍）
            PlayedNote(pitch: 64, startBeat: 40.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 41.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 42.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 62, startBeat: 43.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 60, startBeat: 44.0, duration: 4.0, hand: .right), // ド（4拍）
        ],
        bpm: 96
    )

    /// 初心者：両手版
    static let tulipTwoHands = Arrangement(
        notes: tulip.notes + [
            // セクションA（0-15）
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 4.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            // セクションA'（16-31）
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 20.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
            // セクションB（32-47）
            PlayedNote(pitch: 48, startBeat: 32.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 36.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 40.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 44.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 96
    )

    // MARK: - ちょうちょう（G Mixolydian・白鍵のみ・ABA'形式・20小節）

    /// 超初心者：右手メロディのみ
    static let butterfly = Arrangement(
        notes: [
            // セクションA（0-31）
            PlayedNote(pitch: 67, startBeat: 0.0,  duration: 1.0, hand: .right), // ソ (G4)
            PlayedNote(pitch: 64, startBeat: 1.0,  duration: 1.0, hand: .right), // ミ (E4)
            PlayedNote(pitch: 64, startBeat: 2.0,  duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 65, startBeat: 4.0,  duration: 1.0, hand: .right), // ファ (F4)
            PlayedNote(pitch: 62, startBeat: 5.0,  duration: 1.0, hand: .right), // レ (D4)
            PlayedNote(pitch: 62, startBeat: 6.0,  duration: 2.0, hand: .right), // レ（2拍）
            PlayedNote(pitch: 60, startBeat: 8.0,  duration: 1.0, hand: .right), // ド (C4)
            PlayedNote(pitch: 62, startBeat: 9.0,  duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 10.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 11.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 4.0, hand: .right), // ソ（4拍）
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 64, startBeat: 17.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 18.0, duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 65, startBeat: 20.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 62, startBeat: 21.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 62, startBeat: 22.0, duration: 2.0, hand: .right), // レ（2拍）
            PlayedNote(pitch: 60, startBeat: 24.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 64, startBeat: 25.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 67, startBeat: 26.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 27.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right), // ド（4拍）
            // セクションB（32-63）
            PlayedNote(pitch: 62, startBeat: 32.0, duration: 1.0, hand: .right), // レ (D4)
            PlayedNote(pitch: 62, startBeat: 33.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 34.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 35.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 36.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 65, startBeat: 37.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 38.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 39.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 40.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 41.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 42.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 67, startBeat: 43.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 64, startBeat: 44.0, duration: 4.0, hand: .right), // ミ（4拍）
            PlayedNote(pitch: 62, startBeat: 48.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 62, startBeat: 49.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 50.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 51.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 52.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 65, startBeat: 53.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 54.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 55.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 62, startBeat: 56.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 64, startBeat: 57.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 65, startBeat: 58.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 67, startBeat: 59.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 60.0, duration: 4.0, hand: .right), // ソ（4拍）
            // セクションA'（64-79）
            PlayedNote(pitch: 67, startBeat: 64.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 64, startBeat: 65.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 64, startBeat: 66.0, duration: 2.0, hand: .right), // ミ（2拍）
            PlayedNote(pitch: 65, startBeat: 68.0, duration: 1.0, hand: .right), // ファ
            PlayedNote(pitch: 62, startBeat: 69.0, duration: 1.0, hand: .right), // レ
            PlayedNote(pitch: 62, startBeat: 70.0, duration: 2.0, hand: .right), // レ（2拍）
            PlayedNote(pitch: 60, startBeat: 72.0, duration: 1.0, hand: .right), // ド
            PlayedNote(pitch: 64, startBeat: 73.0, duration: 1.0, hand: .right), // ミ
            PlayedNote(pitch: 67, startBeat: 74.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 67, startBeat: 75.0, duration: 1.0, hand: .right), // ソ
            PlayedNote(pitch: 60, startBeat: 76.0, duration: 4.0, hand: .right), // ド（4拍）
        ],
        bpm: 84
    )

    /// 初心者：両手版
    static let butterflyTwoHands = Arrangement(
        notes: butterfly.notes + [
            // セクションA（0-31）
            PlayedNote(pitch: 55, startBeat: 0.0,  duration: 4.0, hand: .left), // ソ (G3)
            PlayedNote(pitch: 53, startBeat: 4.0,  duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 55, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G3)
            PlayedNote(pitch: 55, startBeat: 16.0, duration: 4.0, hand: .left), // ソ (G3)
            PlayedNote(pitch: 53, startBeat: 20.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
            // セクションB（32-63）
            PlayedNote(pitch: 55, startBeat: 32.0, duration: 4.0, hand: .left), // ソ (G3)
            PlayedNote(pitch: 55, startBeat: 36.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 55, startBeat: 40.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 55, startBeat: 44.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 55, startBeat: 48.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 55, startBeat: 52.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 55, startBeat: 56.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 55, startBeat: 60.0, duration: 4.0, hand: .left),
            // セクションA'（64-79）
            PlayedNote(pitch: 55, startBeat: 64.0, duration: 4.0, hand: .left),
            PlayedNote(pitch: 53, startBeat: 68.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 72.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 76.0, duration: 4.0, hand: .left),
        ],
        bpm: 84
    )

    // MARK: - メヌエット ト長調：本物の楽譜（中級）から難易度別バリエーションを導出

    /// 中間難易度ファイルを基に超初心者・初心者用アレンジを生成する汎用ヘルパー。
    ///
    /// 超初心者は片手・単音のみで弾くため、テンポ自体は原曲と同じにする
    /// （極端に遅くすると間延びして弾きにくくなるため）。
    /// 初心者は両手を合わせる練習になるぶん、少しだけゆっくりにする。
    /// いずれも音価（拍数）は原曲のまま変えないため、難易度間で演奏時間が揃う。
    private static func simplified(from full: Arrangement, for difficulty: Difficulty) -> Arrangement {
        switch difficulty {
        case .superBeginner:
            let melody = full.notes.filter { $0.hand == .right }
            return Arrangement(notes: melody, bpm: full.bpm, beatsPerMeasure: full.beatsPerMeasure)
        case .beginner:
            return Arrangement(notes: full.notes, bpm: full.bpm * 0.85, beatsPerMeasure: full.beatsPerMeasure)
        case .intermediate:
            return full
        }
    }

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
    private static let midiDemoArrangement: Arrangement? =
        MIDIFileParser.loadArrangement(resourceName: "sample_melody", fallbackHand: .right)

    /// 曲ID・難易度から演奏データを取得する。
    /// `Resources/` に以下のファイルがあれば、その優先順位で読み込む（本物の楽譜への切り替え用）:
    ///   1. `<曲ID>-<難易度キー>.musicxml`（楽譜の標準形式。右手/左手・音名・調号が正確）
    ///   2. `<曲ID>-<難易度キー>.mid`（MIDI。手は推測、音名の区別なし）
    /// いずれも無ければ手書きのサンプル／フォールバックを返す。
    static func arrangement(for songID: String, difficulty: Difficulty) -> Arrangement {
        let resourceName = "\(songID)-\(difficulty.resourceKey)"

        if let fromXML = MusicXMLParser.loadArrangement(resourceName: resourceName) {
            return fromXML
        }
        if let fromMIDI = MIDIFileParser.loadArrangement(resourceName: resourceName) {
            return fromMIDI
        }

        // メヌエット ト長調は中級用に本物の楽譜（全32小節）を内蔵済み。
        // 専用ファイルが無い初級・超初心者向けは、それを基に簡略化して提供する。
        if songID == "bach-minuet-g",
           let full = MusicXMLParser.loadArrangement(resourceName: "bach-minuet-g-intermediate") {
            return simplified(from: full, for: difficulty)
        }

        // トルコ行進曲は中級用MXLから超初心者・初心者向けを派生する。
        if songID == "mozart-turkish",
           let full = MusicXMLParser.loadArrangement(resourceName: "mozart-turkish-intermediate") {
            return simplified(from: full, for: difficulty)
        }

        switch (songID, difficulty) {
        case ("beethoven-elise", .superBeginner):
            return furEliseOpening
        case ("beethoven-elise", _):
            return furEliseTwoHands

        case ("beethoven-ode", .superBeginner):
            return odeToJoy
        case ("beethoven-ode", _):
            return odeToJoyTwoHands

        case ("twinkle-star", .superBeginner):
            return twinkleStar
        case ("twinkle-star", _):
            return twinkleStarTwoHands

        case ("frog-song", .superBeginner):
            return frogSong
        case ("frog-song", _):
            return frogSongTwoHands

        case ("tulip", .superBeginner):
            return tulip
        case ("tulip", _):
            return tulipTwoHands

        case ("butterfly", .superBeginner):
            return butterfly
        case ("butterfly", _):
            return butterflyTwoHands

        case ("pachelbel-canon", .superBeginner):
            return pachelbelCanon
        case ("pachelbel-canon", _):
            return pachelbelCanonTwoHands

        case ("bach-air-g-string", .superBeginner):
            return bachAirGString
        case ("bach-air-g-string", _):
            return bachAirGStringTwoHands

        case ("bach-jesu-joy", .superBeginner):
            return bachJesuJoy
        case ("bach-jesu-joy", _):
            return bachJesuJoyTwoHands

        case ("mozart-eine-kleine", .superBeginner):
            return mozartEineKleine
        case ("mozart-eine-kleine", _):
            return mozartEineKleineTwoHands

        case ("mendelssohn-wedding", .superBeginner):
            return mendelssohnWedding
        case ("mendelssohn-wedding", _):
            return mendelssohnWeddingTwoHands

        case ("brahms-lullaby", .superBeginner):
            return brahmsLullaby
        case ("brahms-lullaby", _):
            return brahmsLullabyTwoHands

        case ("strauss-blue-danube", .superBeginner):
            return straussBlueDanube
        case ("strauss-blue-danube", _):
            return straussBlueDanubeTwoHands

        case ("dvorak-going-home", .superBeginner):
            return dvorakGoingHome
        case ("dvorak-going-home", _):
            return dvorakGoingHomeTwoHands

        case ("grieg-morning-mood", .superBeginner):
            return griegMorningMood
        case ("grieg-morning-mood", _):
            return griegMorningMoodTwoHands

        case ("elgar-pomp-circumstance", .superBeginner):
            return elgarPompCircumstance
        case ("elgar-pomp-circumstance", _):
            return elgarPompCircumstanceTwoHands

        case ("chopin-waltz", .superBeginner):
            return chopinWaltz
        case ("chopin-waltz", _):
            return chopinWaltzTwoHands

        case ("schubert-avemaria", .superBeginner):
            return schubertAveMaria
        case ("schubert-avemaria", _):
            return schubertAveMariaTwoHands

        case ("furusato", .superBeginner):
            return furusato
        case ("furusato", _):
            return furusatoTwoHands

        case ("nanatsu-no-ko", .superBeginner):
            return nanatsuNoKo
        case ("nanatsu-no-ko", _):
            return nanatsuNoKoTwoHands

        case ("grandfathers-clock", .superBeginner):
            return grandfathersClock
        case ("grandfathers-clock", _):
            return grandfathersClockTwoHands

        case ("silent-night", .superBeginner):
            return silentNight
        case ("silent-night", _):
            return silentNightTwoHands

        case ("auld-lang-syne", .superBeginner):
            return auldLangSyne
        case ("auld-lang-syne", _):
            return auldLangSyneTwoHands

        case ("mary-lamb", .superBeginner):
            return maryHadALittleLamb
        case ("mary-lamb", _):
            return maryHadALittleLambTwoHands

        case ("london-bridge", .superBeginner):
            return londonBridge
        case ("london-bridge", _):
            return londonBridgeTwoHands

        case ("working-on-railroad", .superBeginner):
            return workingOnTheRailroad
        case ("working-on-railroad", _):
            return workingOnTheRailroadTwoHands

        default:
            return midiDemoArrangement ?? scaleFallback
        }
    }
}
