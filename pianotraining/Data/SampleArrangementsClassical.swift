import Foundation

/// クラシックの名旋律：超初心者向け（右手メロディのみ・ハ長調白鍵）と
/// 初心者向け（両手版）のサンプルアレンジ。
/// いずれもパブリックドメインの楽曲を教育目的でハ長調に移調・簡略化したオリジナルの演奏データ。
extension SampleArrangements {

    // MARK: - パッヘルベルのカノン（パッヘルベル）ハ長調・8小節

    /// 超初心者：右手メロディのみ（有名な和音進行に沿ったアルペジオ）
    static let pachelbelCanon = Arrangement(
        notes: [
            // 1小節目: ド ミ ソ ド
            PlayedNote(pitch: 60, startBeat: 0.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 1.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 3.0,  duration: 1.0, hand: .right),
            // 2小節目: ソ シ レ ソ
            PlayedNote(pitch: 67, startBeat: 4.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 5.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 6.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 7.0,  duration: 1.0, hand: .right),
            // 3小節目: ラ ド ミ ラ
            PlayedNote(pitch: 69, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 76, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ミ ソ シ ミ
            PlayedNote(pitch: 64, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 14.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 76, startBeat: 15.0, duration: 1.0, hand: .right),
            // 5小節目: ファ ラ ド ファ
            PlayedNote(pitch: 65, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ド ミ ソ ド
            PlayedNote(pitch: 60, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: ファ ラ ド ファ
            PlayedNote(pitch: 65, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 72, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 72
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン＝有名な「カノン進行」）
    static let pachelbelCanonTwoHands = Arrangement(
        notes: pachelbelCanon.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 45, startBeat: 8.0,  duration: 4.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 52, startBeat: 12.0, duration: 4.0, hand: .left), // ミ (E3)
            PlayedNote(pitch: 53, startBeat: 16.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 20.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 24.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 28.0, duration: 4.0, hand: .left), // ソ (G2)
        ],
        bpm: 72
    )

    // MARK: - G線上のアリア（バッハ）ハ長調・8小節

    /// 超初心者：右手メロディのみ（ゆったりとした旋律ライン）
    static let bachAirGString = Arrangement(
        notes: [
            // 1小節目: ド（付点2分）シ ラ
            PlayedNote(pitch: 72, startBeat: 0.0,  duration: 3.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 3.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 3.5,  duration: 0.5, hand: .right),
            // 2小節目: ソ ファ ソ ラ シ（2分）
            PlayedNote(pitch: 67, startBeat: 4.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 5.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 5.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 6.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 71, startBeat: 6.5,  duration: 1.5, hand: .right),
            // 3小節目: ド（付点2分）レ
            PlayedNote(pitch: 72, startBeat: 8.0,  duration: 3.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ミ（2分）レ ド
            PlayedNote(pitch: 76, startBeat: 12.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 14.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 15.0, duration: 1.0, hand: .right),
            // 5小節目: シ（2分）ラ ソ
            PlayedNote(pitch: 71, startBeat: 16.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ラ（付点2分）ソ
            PlayedNote(pitch: 69, startBeat: 20.0, duration: 3.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: ファ（2分）ミ レ
            PlayedNote(pitch: 65, startBeat: 24.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 60
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let bachAirGStringTwoHands = Arrangement(
        notes: bachAirGString.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 45, startBeat: 8.0,  duration: 4.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 53, startBeat: 12.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 16.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 45, startBeat: 20.0, duration: 4.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 53, startBeat: 24.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 60
    )

    // MARK: - 主よ、人の望みの喜びよ（バッハ）ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（穏やかに歩むような旋律）
    static let bachJesuJoy = Arrangement(
        notes: [
            // 1小節目: ソ ラ ソ
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0, duration: 1.0, hand: .right),
            // 2小節目: ミ ファ ソ
            PlayedNote(pitch: 64, startBeat: 3.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: ラ ソ ファ
            PlayedNote(pitch: 69, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 7.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 8.0, duration: 1.0, hand: .right),
            // 4小節目: ミ（付点2分）
            PlayedNote(pitch: 64, startBeat: 9.0, duration: 3.0, hand: .right),
            // 5小節目: ド レ ミ
            PlayedNote(pitch: 72, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ソ ラ シ
            PlayedNote(pitch: 67, startBeat: 15.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 17.0, duration: 1.0, hand: .right),
            // 7小節目: ド シ ラ
            PlayedNote(pitch: 72, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 19.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ソ（付点2分）
            PlayedNote(pitch: 67, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 92,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let bachJesuJoyTwoHands = Arrangement(
        notes: bachJesuJoy.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 3.0,  duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 45, startBeat: 6.0,  duration: 3.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 48, startBeat: 9.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 41, startBeat: 12.0, duration: 3.0, hand: .left), // ファ (F2)
            PlayedNote(pitch: 43, startBeat: 15.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 18.0, duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 92,
        beatsPerMeasure: 3
    )

    // MARK: - アイネ・クライネ・ナハトムジーク（モーツァルト）ハ長調・8小節

    /// 超初心者：右手メロディのみ（誰もが知る軽快な冒頭テーマ）
    static let mozartEineKleine = Arrangement(
        notes: [
            // 1小節目: ド ミ ソ ド ミ（2分）レ
            PlayedNote(pitch: 60, startBeat: 0.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 0.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 72, startBeat: 1.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 76, startBeat: 2.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 3.0,  duration: 1.0, hand: .right),
            // 2小節目: ド シ ラ ソ ファ ミ
            PlayedNote(pitch: 72, startBeat: 4.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 5.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 5.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 6.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 7.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 7.5,  duration: 0.5, hand: .right),
            // 3小節目: レ ミ ファ ソ ラ シ ド（2分）
            PlayedNote(pitch: 62, startBeat: 8.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 8.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 65, startBeat: 9.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 9.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 10.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 71, startBeat: 10.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 72, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ド（2分）ソ（2分）
            PlayedNote(pitch: 72, startBeat: 12.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 2.0, hand: .right),
            // 5-7小節目: 1-3小節目の繰り返し
            PlayedNote(pitch: 60, startBeat: 16.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 16.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 17.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 72, startBeat: 17.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 76, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 19.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 21.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 21.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 23.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 23.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 62, startBeat: 24.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 24.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 65, startBeat: 25.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 25.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 26.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 71, startBeat: 26.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 72, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 72, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 120
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let mozartEineKleineTwoHands = Arrangement(
        notes: mozartEineKleine.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 120
    )

    // MARK: - 結婚行進曲（メンデルスゾーン）ハ長調・8小節

    /// 超初心者：右手メロディのみ（誰もが知るファンファーレ風テーマ）
    static let mendelssohnWedding = Arrangement(
        notes: [
            // 1小節目: ド ド ド ド（オクターブ上）
            PlayedNote(pitch: 60, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ソ ソ ミ ミ ド ソ
            PlayedNote(pitch: 67, startBeat: 4.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 4.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 5.0,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 5.5,  duration: 0.5, hand: .right),
            PlayedNote(pitch: 72, startBeat: 6.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 7.0,  duration: 1.0, hand: .right),
            // 3小節目: 1小節目の繰り返し
            PlayedNote(pitch: 60, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ラ ラ ファ ファ ド ソ
            PlayedNote(pitch: 69, startBeat: 12.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 12.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 65, startBeat: 13.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 65, startBeat: 13.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 72, startBeat: 14.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 15.0, duration: 1.0, hand: .right),
            // 5小節目: ファ ミ レ ド
            PlayedNote(pitch: 65, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ソ（2分）ミ ド
            PlayedNote(pitch: 67, startBeat: 20.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: レ ミ ファ ソ
            PlayedNote(pitch: 62, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（オクターブ上・4拍）
            PlayedNote(pitch: 72, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 104
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let mendelssohnWeddingTwoHands = Arrangement(
        notes: mendelssohnWedding.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 4.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 16.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 104
    )

    // MARK: - ブラームスの子守歌 ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（やさしく揺れるような旋律）
    static let brahmsLullaby = Arrangement(
        notes: [
            // 1小節目: ミ ソ ソ ミ
            PlayedNote(pitch: 64, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 2.0, duration: 1.0, hand: .right),
            // 2小節目: ド（2分）ソ
            PlayedNote(pitch: 72, startBeat: 3.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: 1小節目の繰り返し
            PlayedNote(pitch: 64, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 7.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 7.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 8.0, duration: 1.0, hand: .right),
            // 4小節目: レ（2分）ド
            PlayedNote(pitch: 74, startBeat: 9.0,  duration: 2.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 11.0, duration: 1.0, hand: .right),
            // 5小節目: ソ ド シ ラ
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 13.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 71, startBeat: 13.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ソ（付点4分） ミ（付点4分）
            PlayedNote(pitch: 67, startBeat: 15.0, duration: 1.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 16.5, duration: 1.5, hand: .right),
            // 7小節目: レ ファ ラ ソ
            PlayedNote(pitch: 62, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 19.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 69, startBeat: 19.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ド（付点2分）
            PlayedNote(pitch: 60, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 70,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let brahmsLullabyTwoHands = Arrangement(
        notes: brahmsLullaby.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 3.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 6.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 9.0,  duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 15.0, duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 18.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 70,
        beatsPerMeasure: 3
    )

    // MARK: - 美しく青きドナウ（J.シュトラウス2世）ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（優雅なワルツのテーマ）
    static let straussBlueDanube = Arrangement(
        notes: [
            // 1小節目: ド ミ ソ
            PlayedNote(pitch: 60, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0, duration: 1.0, hand: .right),
            // 2小節目: ド（オクターブ上）ソ ミ
            PlayedNote(pitch: 72, startBeat: 3.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: レ ファ ラ
            PlayedNote(pitch: 62, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 7.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 8.0, duration: 1.0, hand: .right),
            // 4小節目: レ（オクターブ上）ラ ファ
            PlayedNote(pitch: 74, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 11.0, duration: 1.0, hand: .right),
            // 5小節目: ソ シ レ（オクターブ上）
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ソ（付点2分）
            PlayedNote(pitch: 67, startBeat: 15.0, duration: 3.0, hand: .right),
            // 7小節目: ド ミ ソ
            PlayedNote(pitch: 60, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 19.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ド（オクターブ上・付点2分）
            PlayedNote(pitch: 72, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 120,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン＝ウィンナワルツのオン・パターン）
    static let straussBlueDanubeTwoHands = Arrangement(
        notes: straussBlueDanube.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 3.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 50, startBeat: 6.0,  duration: 3.0, hand: .left), // レ (D3)
            PlayedNote(pitch: 50, startBeat: 9.0,  duration: 3.0, hand: .left), // レ (D3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 15.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 18.0, duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 120,
        beatsPerMeasure: 3
    )

    // MARK: - 新世界より「家路」（ドヴォルザーク）ハ長調（5音音階）・8小節

    /// 超初心者：右手メロディのみ（望郷を歌う有名な旋律）
    static let dvorakGoingHome = Arrangement(
        notes: [
            // 1小節目: ソ ミ ド（2分）
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 2.0, duration: 2.0, hand: .right),
            // 2小節目: 1小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 6.0, duration: 2.0, hand: .right),
            // 3小節目: レ ミ ソ ミ
            PlayedNote(pitch: 62, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: レ（2分）ド（2分）
            PlayedNote(pitch: 62, startBeat: 12.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 14.0, duration: 2.0, hand: .right),
            // 5小節目: ソ ミ ド（2分）
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 18.0, duration: 2.0, hand: .right),
            // 6小節目: ラ ソ ミ（2分）
            PlayedNote(pitch: 69, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 22.0, duration: 2.0, hand: .right),
            // 7小節目: 3小節目の繰り返し（レ ミ ソ ミ）
            PlayedNote(pitch: 62, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 76
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let dvorakGoingHomeTwoHands = Arrangement(
        notes: dvorakGoingHome.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 4.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 8.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 20.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 76
    )

    // MARK: - ペール・ギュント「朝」（グリーグ）ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（夜明けを描く清々しい旋律）
    static let griegMorningMood = Arrangement(
        notes: [
            // 1小節目: ソ ラ ソ ミ
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 1.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 2.0, duration: 1.0, hand: .right),
            // 2小節目: レ ミ レ ド
            PlayedNote(pitch: 62, startBeat: 3.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 4.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 62, startBeat: 4.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 60, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: 1小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 7.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 7.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 8.0, duration: 1.0, hand: .right),
            // 4小節目: レ（付点2分）
            PlayedNote(pitch: 62, startBeat: 9.0, duration: 3.0, hand: .right),
            // 5小節目: ド レ ミ ソ
            PlayedNote(pitch: 60, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 13.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 13.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ラ ソ ミ レ
            PlayedNote(pitch: 69, startBeat: 15.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 16.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 62, startBeat: 17.0, duration: 1.0, hand: .right),
            // 7小節目: ミ レ ド レ
            PlayedNote(pitch: 64, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 19.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 60, startBeat: 19.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 62, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ド（付点2分）
            PlayedNote(pitch: 60, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 126,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let griegMorningMoodTwoHands = Arrangement(
        notes: griegMorningMood.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 3.0,  duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 6.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 9.0,  duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 15.0, duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 18.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 126,
        beatsPerMeasure: 3
    )

    // MARK: - 威風堂々（エルガー）ハ長調・8小節

    /// 超初心者：右手メロディのみ（卒業式でもおなじみの堂々とした旋律）
    static let elgarPompCircumstance = Arrangement(
        notes: [
            // 1小節目: ド ド ド ソ
            PlayedNote(pitch: 60, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ラ（2分）ソ ファ
            PlayedNote(pitch: 69, startBeat: 4.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 7.0, duration: 1.0, hand: .right),
            // 3小節目: ミ レ ド（2分）
            PlayedNote(pitch: 64, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 10.0, duration: 2.0, hand: .right),
            // 4小節目: ソ（4拍）
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 4.0, hand: .right),
            // 5小節目: ミ ミ ミ ド（オクターブ上）
            PlayedNote(pitch: 64, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: レ（オクターブ上・2分）ド（オクターブ上）シ
            PlayedNote(pitch: 74, startBeat: 20.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: ラ ソ ファ ミ
            PlayedNote(pitch: 69, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（オクターブ上・4拍）
            PlayedNote(pitch: 72, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 80
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let elgarPompCircumstanceTwoHands = Arrangement(
        notes: elgarPompCircumstance.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 4.0,  duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 8.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 20.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 80
    )

    // MARK: - 子犬のワルツ（ショパン）ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（軽やかに駆け回るような旋律）
    static let chopinWaltz = Arrangement(
        notes: [
            // 1小節目: ド シ ド レ ド
            PlayedNote(pitch: 72, startBeat: 0.0,  duration: 0.5,  hand: .right),
            PlayedNote(pitch: 71, startBeat: 0.5,  duration: 0.25, hand: .right),
            PlayedNote(pitch: 72, startBeat: 0.75, duration: 0.25, hand: .right),
            PlayedNote(pitch: 74, startBeat: 1.0,  duration: 1.0,  hand: .right),
            PlayedNote(pitch: 72, startBeat: 2.0,  duration: 1.0,  hand: .right),
            // 2小節目: ソ ミ ド
            PlayedNote(pitch: 67, startBeat: 3.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: 1小節目の繰り返し
            PlayedNote(pitch: 72, startBeat: 6.0,  duration: 0.5,  hand: .right),
            PlayedNote(pitch: 71, startBeat: 6.5,  duration: 0.25, hand: .right),
            PlayedNote(pitch: 72, startBeat: 6.75, duration: 0.25, hand: .right),
            PlayedNote(pitch: 74, startBeat: 7.0,  duration: 1.0,  hand: .right),
            PlayedNote(pitch: 72, startBeat: 8.0,  duration: 1.0,  hand: .right),
            // 4小節目: 2小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 11.0, duration: 1.0, hand: .right),
            // 5小節目: ミ ファ ソ
            PlayedNote(pitch: 64, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ラ ソ ファ
            PlayedNote(pitch: 69, startBeat: 15.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 17.0, duration: 1.0, hand: .right),
            // 7小節目: ミ レ ド
            PlayedNote(pitch: 64, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 19.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ド（付点2分）
            PlayedNote(pitch: 60, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 132,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let chopinWaltzTwoHands = Arrangement(
        notes: chopinWaltz.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 3.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 6.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 9.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 12.0, duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 53, startBeat: 15.0, duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 18.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 132,
        beatsPerMeasure: 3
    )

    // MARK: - アヴェ・マリア（シューベルト）ハ長調・8小節

    /// 超初心者：右手メロディのみ（清らかでゆったりとした旋律）
    static let schubertAveMaria = Arrangement(
        notes: [
            // 1小節目: ド ミ ソ（2分）
            PlayedNote(pitch: 60, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0, duration: 2.0, hand: .right),
            // 2小節目: ド（オクターブ上） シ ラ（2分）
            PlayedNote(pitch: 72, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 6.0, duration: 2.0, hand: .right),
            // 3小節目: ソ ファ ミ（2分）
            PlayedNote(pitch: 67, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 10.0, duration: 2.0, hand: .right),
            // 4小節目: レ（4拍）
            PlayedNote(pitch: 62, startBeat: 12.0, duration: 4.0, hand: .right),
            // 5小節目: ミ ソ ド（オクターブ上・2分）
            PlayedNote(pitch: 64, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 18.0, duration: 2.0, hand: .right),
            // 6小節目: シ ラ ソ（2分）
            PlayedNote(pitch: 71, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 22.0, duration: 2.0, hand: .right),
            // 7小節目: ファ ミ レ（2分）
            PlayedNote(pitch: 65, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 26.0, duration: 2.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 58
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let schubertAveMariaTwoHands = Arrangement(
        notes: schubertAveMaria.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 53, startBeat: 16.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 20.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 58
    )
}
