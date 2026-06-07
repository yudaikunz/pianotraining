import SwiftUI

struct PracticeView: View {
    let song: Song
    let difficulty: Difficulty

    private enum Mode: String, CaseIterable, Identifiable {
        case read = "楽譜を読む"
        case play = "弾いてみる"
        var id: String { rawValue }
    }

    @State private var mode: Mode = .read
    @State private var currentBeat: Double = 0
    @State private var isPlaying = false

    private var arrangement: Arrangement {
        SampleArrangements.arrangement(for: song.id, difficulty: difficulty)
    }

    private var hasLeftHandPart: Bool {
        arrangement.notes.contains { $0.hand == .left }
    }

    private var highlightedPitches: Set<Int> {
        Set(arrangement.notes
            .filter { currentBeat >= $0.startBeat && currentBeat < $0.startBeat + $0.duration }
            .map { $0.pitch })
    }

    private var difficultyColor: Color {
        switch difficulty {
        case .superBeginner: return .green
        case .beginner:      return .blue
        case .intermediate:  return .orange
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            header

            Picker("表示モード", selection: $mode) {
                ForEach(Mode.allCases) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            switch mode {
            case .read:
                readModeContent
            case .play:
                playModeContent
            }

            Spacer()
        }
        .padding(.top, 12)
        .navigationTitle("練習")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: mode) { _, newMode in
            if newMode == .read { isPlaying = false }
        }
        .task(id: isPlaying) {
            guard isPlaying else { return }
            let beatsPerTick = 0.05 * (arrangement.bpm / 60)
            while isPlaying && !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 50_000_000)
                currentBeat += beatsPerTick
                if currentBeat >= arrangement.totalBeats {
                    currentBeat = arrangement.totalBeats
                    isPlaying = false
                }
            }
        }
    }

    // MARK: - 共通ヘッダー

    private var header: some View {
        VStack(spacing: 6) {
            Text(song.title)
                .font(.title2)
                .fontWeight(.bold)
            Text(song.composer)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(difficulty.rawValue)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .background(difficultyColor.opacity(0.15))
                .foregroundStyle(difficultyColor)
                .clipShape(Capsule())
        }
    }

    // MARK: - 「楽譜を読む」モード

    private var readModeContent: some View {
        VStack(spacing: 12) {
            StaffNotationView(arrangement: arrangement)
                .frame(height: 250)
                .padding(.horizontal)

            handLegend

            Text("指でなぞりながら、音符の下のドレミを声に出して読んでみましょう。")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 36)
        }
    }

    private var handLegend: some View {
        HStack(spacing: 20) {
            legendItem(color: .blue, label: "右手（ト音記号）")
            if hasLeftHandPart {
                legendItem(color: .red, label: "左手（ヘ音記号）")
            }
        }
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: 6) {
            Circle().fill(color).frame(width: 10, height: 10)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - 「弾いてみる」モード

    private var playModeContent: some View {
        VStack(spacing: 16) {
            GeometryReader { geo in
                let layout = KeyboardLayout(
                    lowestPitch: 60,
                    octaveCount: 2,
                    width: geo.size.width,
                    keyboardHeight: 130
                )
                VStack(spacing: 6) {
                    FallingNotesView(arrangement: arrangement, currentBeat: currentBeat, layout: layout)
                        .frame(height: 190)
                    PianoKeyboardView(layout: layout, highlightedPitches: highlightedPitches)
                }
            }
            .frame(height: 332)
            .padding(.horizontal)

            handLegend

            controls
        }
    }

    private var controls: some View {
        VStack(spacing: 12) {
            ProgressView(value: currentBeat, total: max(arrangement.totalBeats, 0.01))
                .tint(difficultyColor)
                .padding(.horizontal, 32)

            HStack(spacing: 28) {
                Button {
                    currentBeat = 0
                    isPlaying = false
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                }

                Button {
                    if currentBeat >= arrangement.totalBeats { currentBeat = 0 }
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(difficultyColor)
                }
            }
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(song: SongLibrary.songs.first(where: { $0.id == "bach-minuet-g" })!, difficulty: .beginner)
    }
}
