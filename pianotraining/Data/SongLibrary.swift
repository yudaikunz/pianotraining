import Foundation

struct SongLibrary {
    static let songs: [Song] = [
        Song(
            id: "bach-minuet-g",
            title: "メヌエット ト長調",
            composer: "J.S. バッハ",
            description: "バッハの作品として広く知られる親しみやすいメロディ。初心者の登竜門として最適。",
            period: .baroque,
            availableDifficulties: [.superBeginner, .beginner, .intermediate],
            durationMinutes: 1
        ),
        Song(
            id: "bach-prelude-c",
            title: "プレリュード ハ長調",
            composer: "J.S. バッハ",
            description: "平均律クラヴィーア曲集第1巻より。アルペジオのパターンが美しい。",
            period: .baroque,
            availableDifficulties: [.beginner, .intermediate],
            durationMinutes: 2
        ),
        Song(
            id: "beethoven-elise",
            title: "エリーゼのために",
            composer: "L.v. ベートーヴェン",
            description: "ピアノ学習者に最も親しまれる名曲のひとつ。繰り返しのフレーズが覚えやすい。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner, .intermediate],
            durationMinutes: 3
        ),
        Song(
            id: "beethoven-ode",
            title: "喜びの歌",
            composer: "L.v. ベートーヴェン",
            description: "交響曲第9番「合唱」のテーマ。誰もが知る名旋律をピアノで。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner],
            durationMinutes: 2
        ),
        Song(
            id: "mozart-turkish",
            title: "トルコ行進曲",
            composer: "W.A. モーツァルト",
            description: "ピアノソナタ第11番の終楽章。軽快なリズムと明るい旋律が特徴。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner, .intermediate],
            durationMinutes: 3
        ),
        Song(
            id: "debussy-moonlight",
            title: "月の光",
            composer: "C. ドビュッシー",
            description: "ベルガマスク組曲より。印象派を代表する幻想的なピアノ曲。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner, .intermediate],
            durationMinutes: 5
        ),
        Song(
            id: "chopin-waltz",
            title: "子犬のワルツ",
            composer: "F. ショパン",
            description: "ショパンのワルツ第6番。軽やかで可愛らしい雰囲気が人気。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner, .intermediate],
            durationMinutes: 2
        ),
        Song(
            id: "schubert-avemaria",
            title: "アヴェ・マリア",
            composer: "F. シューベルト",
            description: "清らかで感動的な名曲。ゆっくりとしたテンポで練習しやすい。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner, .intermediate],
            durationMinutes: 4
        ),
    ]
}
