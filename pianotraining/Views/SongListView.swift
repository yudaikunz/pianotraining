import SwiftUI

struct SongListView: View {
    @State private var selectedPeriod: MusicPeriod? = nil
    @State private var searchText = ""
    /// くるくる回すホイールピッカーで選んでいる曲
    @State private var selectedSongID: String = SongLibrary.songs[0].id

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

    private var selectedSong: Song? {
        filteredSongs.first { $0.id == selectedSongID } ?? filteredSongs.first
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                periodFilterBar

                if filteredSongs.isEmpty {
                    emptyState
                } else {
                    songPicker

                    if let song = selectedSong {
                        ScrollView {
                            VStack(spacing: 16) {
                                SongRowView(song: song)

                                NavigationLink(destination: DifficultyView(song: song)) {
                                    HStack {
                                        Text("難易度を選んで練習を始める")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(Color.accentColor.gradient, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .foregroundStyle(.white)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                    }
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
            .onChange(of: filteredSongs.map(\.id)) { _, ids in
                if !ids.contains(selectedSongID), let firstID = ids.first {
                    selectedSongID = firstID
                }
            }
        }
    }

    /// 曲をくるくる回して選ぶホイールピッカー
    private var songPicker: some View {
        Picker("曲を選択", selection: $selectedSongID) {
            ForEach(filteredSongs) { song in
                Text(song.title)
                    .lineLimit(1)
                    .tag(song.id)
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 140)
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
