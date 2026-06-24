import SwiftUI

struct SettingsView: View {
    @AppStorage(AppSettings.themeKey) private var theme: ThemeOption = .system
    @AppStorage(AppSettings.rightHandColorKey) private var rightHandColor: HandColorOption = .blue
    @AppStorage(AppSettings.leftHandColorKey) private var leftHandColor: HandColorOption = .red
    @AppStorage(AppSettings.playbackSpeedKey) private var playbackSpeed = 1.0

    var body: some View {
        Form {
            Section {
                HStack(spacing: 16) {
                    TintedIconView(systemName: "pianokeys", color: .accentColor, size: 60, iconSize: 28, cornerRadius: 18)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("ピアノ練習")
                            .font(.headline)
                        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                            Text("バージョン \(version)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.vertical, 4)
            }

            Section {
                Picker("カラーテーマ", selection: $theme) {
                    ForEach(ThemeOption.allCases) { option in
                        Text(option.label).tag(option)
                    }
                }

                Picker("右手の色", selection: $rightHandColor) {
                    ForEach(HandColorOption.allCases) { option in
                        handColorRow(option)
                    }
                }
                .pickerStyle(.navigationLink)

                Picker("左手の色", selection: $leftHandColor) {
                    ForEach(HandColorOption.allCases) { option in
                        handColorRow(option)
                    }
                }
                .pickerStyle(.navigationLink)

                Picker("再生スピード", selection: $playbackSpeed) {
                    ForEach(AppSettings.playbackSpeedOptions, id: \.self) { speed in
                        Text(speed == 1.0 ? "標準 ×1" : AppSettings.speedText(speed))
                            .tag(speed)
                    }
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text("表示と再生")
            } footer: {
                Text("右手・左手の色は、楽譜・落ちてくる音符・鍵盤のハイライトの色分けに使われます。見分けやすいよう左右で別の色を選ぶのがおすすめです。再生スピードはすべての曲に適用されます。")
            }

            Section("注意書き") {
                ForEach(Self.disclaimers, id: \.self) { text in
                    Label {
                        Text(text)
                            .font(.subheadline)
                    } icon: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }

            Section {
                ForEach(Self.scoreCredits, id: \.title) { credit in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(credit.title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(credit.detail)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            } header: {
                Text("楽譜データの出典・クレジット")
            } footer: {
                Text("収録楽曲はいずれも作曲者の没後、著作権保護期間が過ぎたパブリックドメインの楽曲です。楽譜データは公開楽譜ライブラリ「MuseTrainer」より、著作権の主張表記が無いもの・Public Domainと明記されたもののみを使用しています。")
            }

            Section {
                Text("きらきら星・かえるのうた・チューリップ・ちょうちょう・喜びの歌・パッヘルベルのカノン・故郷・きよしこの夜など、上記の表に無い楽曲は、いずれも作曲者の没後70年以上が経過したパブリックドメインの旋律をもとに、超初心者・初心者向けにアプリ内で作成した簡易演奏データです。")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 2)
            } header: {
                Text("その他の収録曲について")
            }
        }
        .navigationTitle("設定")
    }

    /// 手の色の選択肢1行分（色見本の丸＋色名）
    private func handColorRow(_ option: HandColorOption) -> some View {
        Label {
            Text(option.label)
        } icon: {
            Image(systemName: "circle.fill")
                .foregroundStyle(option.color.gradient)
        }
        .tag(option)
    }

    private static let disclaimers: [String] = [
        "本アプリは練習用アプリです。各難易度のアレンジは原曲を簡略化・編曲したもので、原曲そのものではありません。",
        "再生される音はソフトウェア音源による合成音であり、実際の楽器の録音ではありません。",
        "曲選択画面に表示される演奏時間は、内蔵データから算出した目安です。テンポの感じ方には個人差があります。"
    ]

    private struct ScoreCredit {
        let title: String
        let detail: String
    }

    private static let scoreCredits: [ScoreCredit] = [
        ScoreCredit(
            title: "メヌエット ト長調 BWV Anh.114",
            detail: "クリスティアン・ペッツォルト（バッハ作と長く伝承）／MuseTrainer 公開楽譜ライブラリ"
        ),
        ScoreCredit(
            title: "エリーゼのために",
            detail: "L.v. ベートーヴェン／MuseTrainer 公開楽譜ライブラリ"
        ),
        ScoreCredit(
            title: "プレリュード ハ長調 BWV 846",
            detail: "J.S. バッハ／MuseTrainer 公開楽譜ライブラリ"
        ),
        ScoreCredit(
            title: "トルコ行進曲（ピアノソナタ第11番より）",
            detail: "W.A. モーツァルト／MuseTrainer 公開楽譜ライブラリ"
        ),
        ScoreCredit(
            title: "月の光（ベルガマスク組曲より）",
            detail: "C. ドビュッシー／MuseTrainer 公開楽譜ライブラリ"
        ),
    ]
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
