import Foundation

struct SongLibrary {
    static let songs: [Song] = [

        // MARK: - バロック
        Song(
            id: "bach-minuet-g",
            title: "メヌエット ト長調",
            composer: "J.S. バッハ（ペツォールト）",
            description: "バッハの作品として広く知られる親しみやすいメロディ。初心者の登竜門として最適。",
            period: .baroque,
            availableDifficulties: [.superBeginner, .beginner, .intermediate]
        ),
        Song(
            id: "bach-prelude-c",
            title: "プレリュード ハ長調（BWV 846）",
            composer: "J.S. バッハ",
            description: "平均律クラヴィーア曲集第1巻より。アルペジオのパターンが美しい名曲。",
            period: .baroque,
            availableDifficulties: [.intermediate]
        ),

        // MARK: - 古典
        Song(
            id: "beethoven-elise",
            title: "エリーゼのために（Für Elise）",
            composer: "L.v. ベートーヴェン",
            description: "ピアノ学習者に最も親しまれる名曲のひとつ。繰り返しのフレーズが覚えやすい。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner, .intermediate]
        ),
        Song(
            id: "beethoven-ode",
            title: "喜びの歌（第九より）",
            composer: "L.v. ベートーヴェン",
            description: "交響曲第9番「合唱」のテーマ。誰もが知る名旋律をピアノで楽しもう。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "mozart-turkish",
            title: "トルコ行進曲（Alla Turca）",
            composer: "W.A. モーツァルト",
            description: "ピアノソナタ第11番の終楽章。軽快なリズムと明るい旋律が特徴。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner, .intermediate]
        ),

        // MARK: - ロマン
        Song(
            id: "debussy-moonlight",
            title: "月の光（Clair de Lune）",
            composer: "C. ドビュッシー",
            description: "ベルガマスク組曲より。印象派を代表する幻想的なピアノ曲。",
            period: .romantic,
            availableDifficulties: [.intermediate]
        ),
        Song(
            id: "chopin-waltz",
            title: "子犬のワルツ",
            composer: "F. ショパン",
            description: "ショパンのワルツ第6番。軽やかで可愛らしい雰囲気が人気。",
            period: .romantic,
            availableDifficulties: []
        ),
        Song(
            id: "schubert-avemaria",
            title: "アヴェ・マリア",
            composer: "F. シューベルト",
            description: "清らかで感動的な名曲。ゆっくりとしたテンポで練習しやすい。",
            period: .romantic,
            availableDifficulties: []
        ),

        // MARK: - 民謡・童謡
        Song(
            id: "twinkle-star",
            title: "きらきら星（Twinkle Twinkle Little Star）",
            composer: "フランス民謡",
            description: "世界中で愛される童謡。シンプルなメロディでピアノデビューに最適。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "frog-song",
            title: "かえるのうた（カエルの合唱）",
            composer: "ドイツ民謡",
            description: "ドレミファを順番に弾く練習にぴったりの定番童謡。輪唱でも有名。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "tulip",
            title: "チューリップ",
            composer: "近藤宮子 / 井上武士",
            description: "春の定番童謡。明るいハ長調のメロディが弾きやすく、初心者に人気。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "butterfly",
            title: "ちょうちょう",
            composer: "ドイツ民謡",
            description: "白鍵だけで弾けるやさしいメロディ。ゆっくりとしたテンポで丁寧に練習できる。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
    ]
}
