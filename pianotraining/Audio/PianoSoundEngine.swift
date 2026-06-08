import AVFoundation

/// `AVAudioUnitSampler` にiOS内蔵のサウンドバンク（SoundFont/DLS）からピアノ音色を読み込み、
/// MIDIノート番号を渡すだけで発音・消音できるようにするシンプルな再生エンジン。
final class PianoSoundEngine {
    private let engine = AVAudioEngine()
    private let sampler = AVAudioUnitSampler()
    private var isReady = false

    init() {
        configureAudioSession()
        engine.attach(sampler)
        engine.connect(sampler, to: engine.mainMixerNode, format: nil)
        // 和音や両手パートで複数の音が同時に重なると、各ボイスの音量が単純に
        // 加算されて出力上限（0dBFS）を超え、音割れ（クリッピング）が起きる。
        // 出力にヘッドルームを持たせて、重なっても歪まないようにする。
        engine.mainMixerNode.outputVolume = 0.6
        loadPianoSound()
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
        guard isReady, let note = midiNote(from: pitch) else { return }
        sampler.startNote(note, withVelocity: velocity, onChannel: 0)
    }

    func noteOff(pitch: Int) {
        guard isReady, let note = midiNote(from: pitch) else { return }
        sampler.stopNote(note, onChannel: 0)
    }

    /// 再生の停止・モード切り替え・リセット時に、鳴りっぱなしの音を一括で止める
    func stopAllNotes() {
        guard isReady else { return }
        for note: UInt8 in 0...127 {
            sampler.stopNote(note, onChannel: 0)
        }
    }

    private func midiNote(from pitch: Int) -> UInt8? {
        guard (0...127).contains(pitch) else { return nil }
        return UInt8(pitch)
    }
}
