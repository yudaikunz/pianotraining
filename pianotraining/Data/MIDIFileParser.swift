import Foundation

enum MIDIParseError: Error {
    case invalidHeader
    case invalidTrack
    case unsupportedDivision
}

/// MIDIトラックから読み取った、まだ手（左右）が確定していない生の音符データ
private struct RawNote {
    let pitch: Int
    let startBeat: Double
    let duration: Double
}

/// Standard MIDI File (.mid) を読み込み、演奏データ（Arrangement）に変換する簡易パーサー。
/// フォーマット0/1のテンポ・ノートオン/オフのみに対応（最小限の実装）。
///
/// ピアノ用MIDIの多くは「トラック1＝右手（ト音記号）／トラック2＝左手（ヘ音記号）」という
/// 慣習で書き出されるため、トラックごとの平均音高を比較して自動的に左右の手を割り当てる。
/// 単一トラックにメロディと伴奏が混在している場合は、音高がしきい値（中央ド=60）以上かどうかで
/// 1音ずつ手を判定するフォールバックを用いる。
struct MIDIFileParser {

    /// 中央ド（MIDIノート60）を基準に、これ以上を右手・未満を左手とみなすフォールバックのしきい値
    private static let handPitchThreshold = 60

    /// アプリにバンドルされたMIDIファイルを読み込んで演奏データに変換する。
    /// 複数トラックがある場合はトラックごとの平均音高から左右の手を自動判定する。
    /// 単一トラックの場合は `fallbackHand` を使う（メロディのみのファイル向け）。
    /// 該当ファイルが存在しない場合は他の形式へのフォールバックなので無音で nil を返すが、
    /// ファイルは存在するのに読み込み・解析に失敗した場合はログを出す（バンドル不備の早期発見用）。
    static func loadArrangement(resourceName: String, fallbackHand: Hand = .right) -> Arrangement? {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "mid") else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            print("MIDI読み込み失敗: \(resourceName) のファイルを読み込めませんでした")
            return nil
        }
        do {
            return try parse(data: data, fallbackHand: fallbackHand)
        } catch {
            print("MIDI解析失敗: \(resourceName): \(error)")
            return nil
        }
    }

    static func parse(data: Data, fallbackHand: Hand = .right) throws -> Arrangement {
        var reader = MIDIByteReader(data: data)

        guard reader.readString(length: 4) == "MThd", reader.readUInt32() == 6 else {
            throw MIDIParseError.invalidHeader
        }
        _ = reader.readUInt16() // フォーマット種別（0 or 1）
        let trackCount = reader.readUInt16()
        let division = reader.readUInt16()

        // 最上位ビットが1の場合はSMPTE形式で、本パーサーは未対応
        guard division & 0x8000 == 0 else { throw MIDIParseError.unsupportedDivision }
        let ticksPerBeat = Double(division)

        var bpm: Double = 120
        var tracks: [[RawNote]] = []

        for _ in 0..<trackCount {
            let (notes, tempo) = try readTrack(&reader, ticksPerBeat: ticksPerBeat)
            if let tempo { bpm = tempo }
            if !notes.isEmpty { tracks.append(notes) }
        }

        let notes = assignHands(to: tracks, fallbackHand: fallbackHand)
            .sorted { $0.startBeat < $1.startBeat }
        return Arrangement(notes: notes, bpm: bpm)
    }

    /// 1トラック分のイベントを読み取り、音符データと（あれば）テンポ指定を返す
    private static func readTrack(_ reader: inout MIDIByteReader, ticksPerBeat: Double) throws -> ([RawNote], Double?) {
        guard reader.readString(length: 4) == "MTrk" else { throw MIDIParseError.invalidTrack }
        let trackLength = Int(reader.readUInt32())
        let trackEnd = reader.offset + trackLength

        var notes: [RawNote] = []
        var tempo: Double?
        var ticks: UInt32 = 0
        var runningStatus: UInt8 = 0
        var activeNoteStartTicks: [Int: UInt32] = [:] // pitch -> 開始tick

        while reader.offset < trackEnd {
            ticks += reader.readVariableLength()

            var status = reader.peekByte()
            if status & 0x80 != 0 {
                status = reader.readByte()
                if status < 0xF0 { runningStatus = status }
            } else {
                status = runningStatus // ランニングステータス（省略された場合）
            }

            switch status {
            case 0xFF: // メタイベント
                let metaType = reader.readByte()
                let length = Int(reader.readVariableLength())
                let bytes = reader.readBytes(count: length)
                if metaType == 0x51, bytes.count == 3 { // テンポ指定
                    let microsPerBeat = (UInt32(bytes[0]) << 16) | (UInt32(bytes[1]) << 8) | UInt32(bytes[2])
                    if microsPerBeat > 0 {
                        tempo = 60_000_000.0 / Double(microsPerBeat)
                    }
                }

            case 0xF0, 0xF7: // SysExイベント（内容は無視）
                let length = Int(reader.readVariableLength())
                _ = reader.readBytes(count: length)

            default:
                let messageType = status & 0xF0
                switch messageType {
                case 0x90, 0x80: // Note On / Note Off
                    let pitch = Int(reader.readByte())
                    let velocity = reader.readByte()
                    let isNoteOn = (messageType == 0x90 && velocity > 0)

                    if isNoteOn {
                        activeNoteStartTicks[pitch] = ticks
                    } else if let startTicks = activeNoteStartTicks.removeValue(forKey: pitch) {
                        notes.append(RawNote(
                            pitch: pitch,
                            startBeat: Double(startTicks) / ticksPerBeat,
                            duration: max(Double(ticks - startTicks) / ticksPerBeat, 0.1)
                        ))
                    }

                case 0xA0, 0xB0, 0xE0: // ポリフォニックアフタータッチ／コントロールチェンジ／ピッチベンド（2バイト）
                    _ = reader.readByte()
                    _ = reader.readByte()

                case 0xC0, 0xD0: // プログラムチェンジ／チャンネルアフタータッチ（1バイト）
                    _ = reader.readByte()

                default:
                    break
                }
            }
        }
        reader.seek(to: trackEnd)
        return (notes, tempo)
    }

    /// トラックごとの生の音符データに左右の手を割り当てる
    private static func assignHands(to tracks: [[RawNote]], fallbackHand: Hand) -> [PlayedNote] {
        switch tracks.count {
        case 0:
            return []

        case 1:
            // 単一トラック：メロディのみのファイルは fallbackHand を採用しつつ、
            // 低音域の音は左手の伴奏とみなして自動的に振り分ける
            return tracks[0].map { raw in
                let hand: Hand = raw.pitch < handPitchThreshold ? .left : fallbackHand
                return PlayedNote(pitch: raw.pitch, startBeat: raw.startBeat, duration: raw.duration, hand: hand)
            }

        default:
            // 複数トラック：平均音高が高いトラック群を右手、低いトラック群を左手とみなす
            // （ピアノ用MIDIの「トラック1＝右手 / トラック2＝左手」という慣習に対応）
            let averages = tracks.map { track -> Double in
                let total = track.reduce(0) { $0 + $1.pitch }
                return Double(total) / Double(track.count)
            }
            let overallAverage = averages.reduce(0, +) / Double(averages.count)

            var notes: [PlayedNote] = []
            for (index, track) in tracks.enumerated() {
                let hand: Hand = averages[index] >= overallAverage ? .right : .left
                notes += track.map {
                    PlayedNote(pitch: $0.pitch, startBeat: $0.startBeat, duration: $0.duration, hand: hand)
                }
            }
            return notes
        }
    }
}

/// MIDIバイナリデータを先頭から順に読み進めるヘルパー。
/// 破損・切り詰められたファイルでもクラッシュしないよう、末尾を越える読み出しは0／空を返す。
private struct MIDIByteReader {
    let data: Data
    private(set) var offset = 0

    init(data: Data) { self.data = data }

    mutating func readByte() -> UInt8 {
        guard offset < data.count else {
            offset += 1
            return 0
        }
        let byte = data[data.startIndex + offset]
        offset += 1
        return byte
    }

    func peekByte() -> UInt8 {
        guard offset < data.count else { return 0 }
        return data[data.startIndex + offset]
    }

    mutating func readBytes(count: Int) -> [UInt8] {
        let start = min(offset, data.count)
        let end = min(offset + count, data.count)
        offset += count
        guard start < end else { return [] }
        let base = data.startIndex
        return Array(data[(base + start)..<(base + end)])
    }

    mutating func readString(length: Int) -> String {
        String(decoding: readBytes(count: length), as: UTF8.self)
    }

    mutating func readUInt16() -> UInt16 {
        (UInt16(readByte()) << 8) | UInt16(readByte())
    }

    mutating func readUInt32() -> UInt32 {
        (UInt32(readByte()) << 24) | (UInt32(readByte()) << 16) | (UInt32(readByte()) << 8) | UInt32(readByte())
    }

    /// MIDIの可変長数値（Variable Length Quantity）を読み取る
    mutating func readVariableLength() -> UInt32 {
        var value: UInt32 = 0
        while true {
            let byte = readByte()
            value = (value << 7) | UInt32(byte & 0x7F)
            if byte & 0x80 == 0 { break }
        }
        return value
    }

    mutating func seek(to newOffset: Int) {
        offset = newOffset
    }
}
