import AVFoundation

/// `AVAudioUnitSampler` にiOS内蔵のサウンドバンク（SoundFont/DLS）からピアノ音色を読み込み、
/// MIDIノート番号を渡すだけで発音・消音できるようにするシンプルな再生エンジン。
final class PianoSoundEngine {
    private let engine = AVAudioEngine()
    private let sampler = AVAudioUnitSampler()
    /// 音源の読み込みとエンジン起動まで完了し、発音できる状態か
    private var isReady = false
    /// オーディオグラフ（セッション＋ノード接続）を構成済みか。
    /// ノードの接続は一度きりにする必要がある（二重 attach はクラッシュの原因）。
    private var graphConfigured = false
    /// 現在発音中のMIDIノート。一括停止で実際に鳴っている音だけを止めるために保持する。
    private var soundingNotes: Set<UInt8> = []

    deinit {
        teardown()
    }

    /// 練習画面を離れたら、エンジンを止めてオーディオセッションを解放する。
    /// 解放しないと、他アプリ（音楽など）が中断・音量低下されたままになる。
    func teardown() {
        guard graphConfigured else { return }
        engine.stop()
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("オーディオセッションの解放に失敗しました: \(error)")
        }
    }

    /// オーディオセッションの有効化と音源の読み込みは、実際に最初の音を鳴らす直前まで遅らせる。
    /// SwiftUIの NavigationLink は遷移前に destination のViewを初期化するため、
    /// init で準備してしまうと「練習画面を開いてもいないのに他アプリの音楽が中断され、
    /// オーディオエンジンが複数同時に起動する」という不安定な挙動になる。
    private func setupIfNeeded() {
        if !graphConfigured {
            configureAudioSession()
            engine.attach(sampler)
            engine.connect(sampler, to: engine.mainMixerNode, format: nil)
            // 和音や両手パートで複数の音が同時に重なると、各ボイスの音量が単純に
            // 加算されて出力上限（0dBFS）を超え、音割れ（クリッピング）が起きる。
            // 出力にヘッドルームを持たせて、重なっても歪まないようにする。
            engine.mainMixerNode.outputVolume = 0.6
            graphConfigured = true
        }

        if !isReady {
            // 初回の音源読み込みに失敗していても、次に音を鳴らすときに再試行する
            // （一時的な失敗で以降ずっと無音になるのを防ぐ）。
            loadPianoSound()
        } else if !engine.isRunning {
            // 電話や他アプリの割り込みでエンジンが停止した場合は再開を試みる
            try? engine.start()
        }
    }

    /// マナーモード（消音スイッチ）がオンでも練習中の音が聞こえるよう再生用カテゴリを設定する
    private func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("オーディオセッションの設定に失敗しました: \(error)")
        }
    }

    /// iOS / iPadOS に標準搭載されているDLSサウンドバンクからグランドピアノ音色を読み込む。
    /// プログラム0・バンク121（General MIDI標準のピアノ系バンク）を指定。
    private func loadPianoSound() {
        let bankURL = URL(fileURLWithPath: "/System/Library/Components/CoreAudio.component/Contents/Resources/gs_instruments.dls")
        do {
            try sampler.loadSoundBankInstrument(at: bankURL, program: 0, bankMSB: 0x79, bankLSB: 0x00)
            try engine.start()
            isReady = true
        } catch {
            print("ピアノ音源の読み込みに失敗しました: \(error)")
        }
    }

    func noteOn(pitch: Int, velocity: UInt8 = 75) {
        setupIfNeeded()
        guard isReady, let note = midiNote(from: pitch) else { return }
        sampler.startNote(note, withVelocity: velocity, onChannel: 0)
        soundingNotes.insert(note)
    }

    func noteOff(pitch: Int) {
        guard isReady, let note = midiNote(from: pitch) else { return }
        sampler.stopNote(note, onChannel: 0)
        soundingNotes.remove(note)
    }

    /// 再生の停止・モード切り替え・リセット時に、鳴りっぱなしの音を一括で止める
    func stopAllNotes() {
        guard isReady else { return }
        for note in soundingNotes {
            sampler.stopNote(note, onChannel: 0)
        }
        soundingNotes.removeAll()
    }

    private func midiNote(from pitch: Int) -> UInt8? {
        guard (0...127).contains(pitch) else { return nil }
        return UInt8(pitch)
    }
}
