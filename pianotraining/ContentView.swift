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
    /// 起動直後だけスプラッシュ画面を表示するためのフラグ
    @State private var showLaunchScreen = true

    var body: some View {
        ZStack {
            SongListView()

            if showLaunchScreen {
                LaunchScreenView()
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(theme.colorScheme)
        .task {
            try? await Task.sleep(nanoseconds: 1_300_000_000)
            withAnimation(.easeOut(duration: 0.4)) {
                showLaunchScreen = false
            }
        }
    }
}

#Preview {
    ContentView()
}
