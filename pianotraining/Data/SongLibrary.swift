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
        Song(
            id: "pachelbel-canon",
            title: "パッヘルベルのカノン",
            composer: "J. パッヘルベル",
            description: "結婚式やCMでもおなじみの名曲。同じ和音進行が繰り返される、落ち着いた雰囲気が魅力。",
            period: .baroque,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "bach-air-g-string",
            title: "G線上のアリア",
            composer: "J.S. バッハ",
            description: "管弦楽組曲第3番より。ゆったりとした旋律が美しい、バッハの代表的な名曲。",
            period: .baroque,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "bach-jesu-joy",
            title: "主よ、人の望みの喜びよ",
            composer: "J.S. バッハ",
            description: "カンタータ第147番より。3連符の伴奏にのる穏やかな旋律が特徴。",
            period: .baroque,
            availableDifficulties: [.superBeginner, .beginner]
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
        Song(
            id: "mozart-eine-kleine",
            title: "アイネ・クライネ・ナハトムジーク",
            composer: "W.A. モーツァルト",
            description: "セレナード第13番 第1楽章。誰もが一度は耳にしたことのある軽快なテーマ。",
            period: .classical,
            availableDifficulties: [.superBeginner, .beginner]
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
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "schubert-avemaria",
            title: "アヴェ・マリア",
            composer: "F. シューベルト",
            description: "清らかで感動的な名曲。ゆっくりとしたテンポで練習しやすい。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "mendelssohn-wedding",
            title: "結婚行進曲",
            composer: "F. メンデルスゾーン",
            description: "劇音楽「夏の夜の夢」より。結婚式の定番として世界中で親しまれるファンファーレ。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "brahms-lullaby",
            title: "ブラームスの子守歌",
            composer: "J. ブラームス",
            description: "世界中で歌われる定番の子守歌。やさしく揺れるような旋律が魅力。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "strauss-blue-danube",
            title: "美しく青きドナウ",
            composer: "J. シュトラウス2世",
            description: "「ワルツの王」の代表作。優雅な3拍子のメロディがウィンナワルツの魅力を伝える。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "dvorak-going-home",
            title: "新世界より「家路」",
            composer: "A. ドヴォルザーク",
            description: "交響曲第9番「新世界より」第2楽章のメロディ。望郷の想いを込めた美しい旋律。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "grieg-morning-mood",
            title: "ペール・ギュント「朝」",
            composer: "E. グリーグ",
            description: "組曲「ペール・ギュント」より。夜明けの情景を描いた、清々しい旋律が魅力。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "elgar-pomp-circumstance",
            title: "威風堂々",
            composer: "E. エルガー",
            description: "行進曲集「威風堂々」第1番より。卒業式などでもおなじみの堂々とした旋律。",
            period: .romantic,
            availableDifficulties: [.superBeginner, .beginner]
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
        Song(
            id: "furusato",
            title: "故郷（ふるさと）",
            composer: "岡野貞一",
            description: "文部省唱歌の代表曲。3拍子の落ち着いた旋律にのせて歌われる、日本の心の歌。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "nanatsu-no-ko",
            title: "七つの子",
            composer: "本居長世",
            description: "野口雨情作詞による童謡の名作。優しく語りかけるような旋律が特徴。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "grandfathers-clock",
            title: "大きな古時計",
            composer: "ヘンリー・クレイ・ワーク",
            description: "アメリカ生まれの民謡。3拍子のゆったりとしたワルツ調が特徴。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "silent-night",
            title: "きよしこの夜",
            composer: "F. グルーバー",
            description: "世界中で歌われるクリスマスの定番曲。静かで穏やかな3拍子の旋律。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "auld-lang-syne",
            title: "蛍の光",
            composer: "スコットランド民謡",
            description: "卒業式や別れの場面でおなじみの旋律。世界中で愛される「別れの歌」。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "mary-lamb",
            title: "メリーさんの羊",
            composer: "アメリカ民謡",
            description: "誰もが一度は弾いたことのある、ドレミだけで弾けるシンプルな童謡。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "london-bridge",
            title: "ロンドン橋",
            composer: "イギリス民謡",
            description: "世界中で親しまれるマザーグースの童謡。リズミカルで覚えやすい旋律。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
        Song(
            id: "working-on-railroad",
            title: "線路は続くよどこまでも",
            composer: "アメリカ民謡",
            description: "軽快なリズムが楽しい定番の童謡。元気よく歩くようなテンポが特徴。",
            period: .folk,
            availableDifficulties: [.superBeginner, .beginner]
        ),
    ]
}
