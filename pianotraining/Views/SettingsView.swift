import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.accentColor.opacity(0.15))
                                .frame(width: 60, height: 60)
                            Image(systemName: "pianokeys")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundStyle(Color.accentColor)
                        }
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
                    Text("きらきら星・かえるのうた・チューリップ・ちょうちょう・喜びの歌などは、パブリックドメインの童謡・民謡・旋律をもとにアプリ内で作成した簡易演奏データです。")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 2)
                } header: {
                    Text("その他の収録曲について")
                }
            }
            .navigationTitle("設定")
        }
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
    SettingsView()
}
