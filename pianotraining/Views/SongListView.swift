import SwiftUI

struct SongListView: View {
    @State private var selectedPeriod: MusicPeriod? = nil
    @State private var searchText = ""

    var filteredSongs: [Song] {
        var result = SongLibrary.songs
        if let period = selectedPeriod {
            result = result.filter { $0.period == period }
        }
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedStandardContains(searchText) ||
                $0.composer.localizedStandardContains(searchText)
            }
        }
        return result
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                periodFilterBar

                if filteredSongs.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(filteredSongs) { song in
                                NavigationLink(destination: DifficultyView(song: song)) {
                                    SongRowView(song: song)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                    .animation(.default, value: filteredSongs.map { $0.id })
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("ピアノ練習")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "曲名・作曲家で検索")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }

    private var periodFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                FilterChip(title: "すべて", isSelected: selectedPeriod == nil) {
                    withAnimation { selectedPeriod = nil }
                }
                ForEach(MusicPeriod.allCases, id: \.self) { period in
                    FilterChip(title: period.rawValue, isSelected: selectedPeriod == period) {
                        withAnimation { selectedPeriod = (selectedPeriod == period) ? nil : period }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "music.note.list")
                .font(.system(size: 56))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.accentColor)
            Text("曲が見つかりません")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview {
    SongListView()
}
