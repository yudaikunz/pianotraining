//
//  ContentView.swift
//  pianotraining
//
//  Created by Yudai on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    /// 設定画面で選んだカラーテーマ。@AppStorage なので変更すると即座に全画面へ反映される
    @AppStorage(AppSettings.themeKey) private var theme: ThemeOption = .system

    var body: some View {
        SongListView()
            .preferredColorScheme(theme.colorScheme)
    }
}

#Preview {
    ContentView()
}
