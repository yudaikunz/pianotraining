//
//  ContentView.swift
//  pianotraining
//
//  Created by Yudai on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SongListView()
                .tabItem {
                    Label("曲一覧", systemImage: "music.note.list")
                }

            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
