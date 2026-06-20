import Foundation

/// 童謡・民謡の名旋律：超初心者向け（右手メロディのみ・ハ長調白鍵）と
/// 初心者向け（両手版）のサンプルアレンジ。
/// いずれもパブリックドメインの楽曲を教育目的でハ長調に移調・簡略化したオリジナルの演奏データ。
extension SampleArrangements {

    // MARK: - 故郷（ふるさと）ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（「うさぎ追いし かの山」の冒頭フレーズ）
    static let furusato = Arrangement(
        notes: [
            // 1小節目: ミ ソ ソ（うさぎ）
            PlayedNote(pitch: 64, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0, duration: 1.0, hand: .right),
            // 2小節目: ミ レ ド（おいし）
            PlayedNote(pitch: 64, startBeat: 3.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: レ レ レ（かのや）
            PlayedNote(pitch: 62, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 7.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 8.0, duration: 1.0, hand: .right),
            // 4小節目: ド（付点2分・ま）
            PlayedNote(pitch: 60, startBeat: 9.0, duration: 3.0, hand: .right),
            // 5小節目: ミ ソ ソ（こぶな）
            PlayedNote(pitch: 64, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ミ レ ド（つりし）
            PlayedNote(pitch: 64, startBeat: 15.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 17.0, duration: 1.0, hand: .right),
            // 7小節目: レ ミ レ（かのか）
            PlayedNote(pitch: 62, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 19.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ド（付点2分・わ）
            PlayedNote(pitch: 60, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 84,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let furusatoTwoHands = Arrangement(
        notes: furusato.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 3.0,  duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 6.0,  duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 9.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 15.0, duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 43, startBeat: 18.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 84,
        beatsPerMeasure: 3
    )

    // MARK: - 七つの子 ハ長調（5音音階）・8小節

    /// 超初心者：右手メロディのみ（「からす なぜなくの」の冒頭フレーズ）
    static let nanatsuNoKo = Arrangement(
        notes: [
            // 1小節目: ラ ド ド ラ
            PlayedNote(pitch: 69, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ソ ラ ソ ミ
            PlayedNote(pitch: 67, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 7.0, duration: 1.0, hand: .right),
            // 3小節目: 1小節目の繰り返し
            PlayedNote(pitch: 69, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ソ（2分） ミ（2分）
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 14.0, duration: 2.0, hand: .right),
            // 5小節目: レ ミ ソ ラ
            PlayedNote(pitch: 62, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ソ ミ レ（2分）
            PlayedNote(pitch: 67, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 22.0, duration: 2.0, hand: .right),
            // 7小節目: 1小節目の繰り返し
            PlayedNote(pitch: 69, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ソ（4拍）
            PlayedNote(pitch: 67, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 88
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let nanatsuNoKoTwoHands = Arrangement(
        notes: nanatsuNoKo.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 45, startBeat: 12.0, duration: 4.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 43, startBeat: 16.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 45, startBeat: 20.0, duration: 4.0, hand: .left), // ラ (A2)
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 28.0, duration: 4.0, hand: .left), // ソ (G2)
        ],
        bpm: 88
    )

    // MARK: - 大きな古時計 ハ長調・4/4拍子・8小節

    /// 超初心者：右手メロディのみ（「大きなのっぽの古時計」の冒頭フレーズ）
    static let grandfathersClock = Arrangement(
        notes: [
            // 1小節目: ソ ソ ラ ソ（大きなのっ）
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ミ ソ ミ レ（ぽの古時）
            PlayedNote(pitch: 64, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 7.0, duration: 1.0, hand: .right),
            // 3小節目: ド レ ミ ソ（計おじい）
            PlayedNote(pitch: 60, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ラ（2拍）ソ（2拍）（さんの時計）
            PlayedNote(pitch: 69, startBeat: 12.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 2.0, hand: .right),
            // 5小節目: 1小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: 2小節目の繰り返し
            PlayedNote(pitch: 64, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: ド ミ ソ ミ
            PlayedNote(pitch: 60, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（全音符）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 72,
        beatsPerMeasure: 4
    )

    /// 初心者：両手版（右手メロディ＋左手ルート音伴奏）
    static let grandfathersClockTwoHands = Arrangement(
        notes: grandfathersClock.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3) = I
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2) = V
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3) = I
            PlayedNote(pitch: 53, startBeat: 12.0, duration: 4.0, hand: .left), // ファ (F3) = IV
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3) = I
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2) = V
            PlayedNote(pitch: 48, startBeat: 24.0, duration: 4.0, hand: .left), // ド (C3) = I
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3) = I
        ],
        bpm: 72,
        beatsPerMeasure: 4
    )

    // MARK: - きよしこの夜 ハ長調・3拍子・8小節

    /// 超初心者：右手メロディのみ（クリスマスの定番曲の冒頭フレーズ）
    static let silentNight = Arrangement(
        notes: [
            // 1小節目: ソ ラ ソ ミ（2分）
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 1.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 2.0, duration: 1.0, hand: .right),
            // 2小節目: 1小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 3.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 4.0, duration: 0.5, hand: .right),
            PlayedNote(pitch: 67, startBeat: 4.5, duration: 0.5, hand: .right),
            PlayedNote(pitch: 64, startBeat: 5.0, duration: 1.0, hand: .right),
            // 3小節目: ド（オクターブ上） ド シ
            PlayedNote(pitch: 72, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 7.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 8.0, duration: 1.0, hand: .right),
            // 4小節目: ラ ラ ソ
            PlayedNote(pitch: 69, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 11.0, duration: 1.0, hand: .right),
            // 5小節目: レ（オクターブ上） レ シ
            PlayedNote(pitch: 74, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 14.0, duration: 1.0, hand: .right),
            // 6小節目: ド（オクターブ上） ド ラ
            PlayedNote(pitch: 72, startBeat: 15.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 17.0, duration: 1.0, hand: .right),
            // 7小節目: ソ ファ レ
            PlayedNote(pitch: 67, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 19.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 20.0, duration: 1.0, hand: .right),
            // 8小節目: ド（付点2分）
            PlayedNote(pitch: 60, startBeat: 21.0, duration: 3.0, hand: .right),
        ],
        bpm: 66,
        beatsPerMeasure: 3
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let silentNightTwoHands = Arrangement(
        notes: silentNight.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 3.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 53, startBeat: 6.0,  duration: 3.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 9.0,  duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 3.0, hand: .left), // ソ (G2) = V（右手レ・シはGコード(ソシレ)の音）
            PlayedNote(pitch: 48, startBeat: 15.0, duration: 3.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 18.0, duration: 3.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 21.0, duration: 3.0, hand: .left), // ド (C3)
        ],
        bpm: 66,
        beatsPerMeasure: 3
    )

    // MARK: - 蛍の光（Auld Lang Syne）ハ長調・8小節

    /// 超初心者：右手メロディのみ（卒業式・別れの場面でおなじみの旋律）
    static let auldLangSyne = Arrangement(
        notes: [
            // 1小節目: ド ド ファ ラ
            PlayedNote(pitch: 60, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ソ（2分） ファ レ
            PlayedNote(pitch: 67, startBeat: 4.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 7.0, duration: 1.0, hand: .right),
            // 3小節目: 1小節目の繰り返し
            PlayedNote(pitch: 60, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: ソ（4拍）
            PlayedNote(pitch: 67, startBeat: 12.0, duration: 4.0, hand: .right),
            // 5小節目: 1小節目の繰り返し
            PlayedNote(pitch: 60, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: 2小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 20.0, duration: 2.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: ド ラ ファ レ
            PlayedNote(pitch: 60, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 84
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let auldLangSyneTwoHands = Arrangement(
        notes: auldLangSyne.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 53, startBeat: 24.0, duration: 4.0, hand: .left), // ファ (F3)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 84
    )

    // MARK: - メリーさんの羊（Mary Had a Little Lamb）ハ長調・8小節

    /// 超初心者：右手メロディのみ（ドレミだけで弾けるシンプルな旋律）
    static let maryHadALittleLamb = Arrangement(
        notes: [
            // 1小節目: ミ レ ド レ
            PlayedNote(pitch: 64, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ミ ミ ミ（2分）
            PlayedNote(pitch: 64, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 6.0, duration: 2.0, hand: .right),
            // 3小節目: レ レ レ（2分）
            PlayedNote(pitch: 62, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 10.0, duration: 2.0, hand: .right),
            // 4小節目: ミ ソ ソ（2分）
            PlayedNote(pitch: 64, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 2.0, hand: .right),
            // 5小節目: 1小節目の繰り返し
            PlayedNote(pitch: 64, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ミ ミ ミ ミ
            PlayedNote(pitch: 64, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: レ レ ミ レ
            PlayedNote(pitch: 62, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 104
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let maryHadALittleLambTwoHands = Arrangement(
        notes: maryHadALittleLamb.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 4.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 12.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 20.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 104
    )

    // MARK: - ロンドン橋（London Bridge）ハ長調・8小節

    /// 超初心者：右手メロディのみ（リズミカルで覚えやすいマザーグースの旋律）
    static let londonBridge = Arrangement(
        notes: [
            // 1小節目: ソ ラ ソ ファ
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ミ ファ ソ（2分）
            PlayedNote(pitch: 64, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 6.0, duration: 2.0, hand: .right),
            // 3小節目: レ ミ ファ（2分）
            PlayedNote(pitch: 62, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 64, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 10.0, duration: 2.0, hand: .right),
            // 4小節目: ミ ファ ソ（2分）
            PlayedNote(pitch: 64, startBeat: 12.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 13.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 14.0, duration: 2.0, hand: .right),
            // 5小節目: 1小節目の繰り返し
            PlayedNote(pitch: 67, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ミ ファ ソ レ
            PlayedNote(pitch: 64, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 65, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 22.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 23.0, duration: 1.0, hand: .right),
            // 7小節目: ド レ ド（2分）
            PlayedNote(pitch: 60, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 62, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 60, startBeat: 26.0, duration: 2.0, hand: .right),
            // 8小節目: ド（4拍）
            PlayedNote(pitch: 60, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 108
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let londonBridgeTwoHands = Arrangement(
        notes: londonBridge.notes + [
            PlayedNote(pitch: 48, startBeat: 0.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 20.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 108
    )

    // MARK: - 線路は続くよどこまでも（I've Been Working on the Railroad）ハ長調・8小節

    /// 超初心者：右手メロディのみ（軽快なリズムが楽しい定番童謡）
    static let workingOnTheRailroad = Arrangement(
        notes: [
            // 1小節目: ソ ソ ソ ソ
            PlayedNote(pitch: 67, startBeat: 0.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 1.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 2.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 3.0, duration: 1.0, hand: .right),
            // 2小節目: ソ ソ シ ラ
            PlayedNote(pitch: 67, startBeat: 4.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 67, startBeat: 5.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 6.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 7.0, duration: 1.0, hand: .right),
            // 3小節目: ソ ラ シ ド（オクターブ上）
            PlayedNote(pitch: 67, startBeat: 8.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 69, startBeat: 9.0,  duration: 1.0, hand: .right),
            PlayedNote(pitch: 71, startBeat: 10.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 11.0, duration: 1.0, hand: .right),
            // 4小節目: レ（オクターブ上・4拍）
            PlayedNote(pitch: 74, startBeat: 12.0, duration: 4.0, hand: .right),
            // 5小節目: レ レ レ レ（オクターブ上）
            PlayedNote(pitch: 74, startBeat: 16.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 17.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 18.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 19.0, duration: 1.0, hand: .right),
            // 6小節目: ミ レ ド（2分・オクターブ上）
            PlayedNote(pitch: 76, startBeat: 20.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 21.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 22.0, duration: 2.0, hand: .right),
            // 7小節目: シ ド レ ド（オクターブ上）
            PlayedNote(pitch: 71, startBeat: 24.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 25.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 74, startBeat: 26.0, duration: 1.0, hand: .right),
            PlayedNote(pitch: 72, startBeat: 27.0, duration: 1.0, hand: .right),
            // 8小節目: ド（オクターブ上・4拍）
            PlayedNote(pitch: 72, startBeat: 28.0, duration: 4.0, hand: .right),
        ],
        bpm: 120
    )

    /// 初心者：両手版（右手メロディ＋左手バスライン）
    static let workingOnTheRailroadTwoHands = Arrangement(
        notes: workingOnTheRailroad.notes + [
            PlayedNote(pitch: 43, startBeat: 0.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 43, startBeat: 4.0,  duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 8.0,  duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 12.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 16.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 48, startBeat: 20.0, duration: 4.0, hand: .left), // ド (C3)
            PlayedNote(pitch: 43, startBeat: 24.0, duration: 4.0, hand: .left), // ソ (G2)
            PlayedNote(pitch: 48, startBeat: 28.0, duration: 4.0, hand: .left), // ド (C3)
        ],
        bpm: 120
    )
}
