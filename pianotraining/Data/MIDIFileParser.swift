import Foundation

enum MIDIParseError: Error {
    case invalidHeader
    case invalidTrack
    case unsupportedDivision
}

/// Standard MIDI File (.mid) を読み込み、演奏データ（Arrangement）に変換する簡易パーサー。
/// フォーマット0/1のテンポ・ノートオン/オフのみに対応（最小限の実装）。
struct MIDIFileParser {

    /// アプリにバンドルされたMIDIファイルを読み込んで演奏データに変換する
    static func loadArrangement(resourceName: String, hand: Hand = .right) -> Arrangement? {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "mid"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? parse(data: data, hand: hand)
    }

    static func parse(data: Data, hand: Hand) throws -> Arrangement {
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

        var notes: [PlayedNote] = []
        var bpm: Double = 120

        for _ in 0..<trackCount {
            guard reader.readString(length: 4) == "MTrk" else { throw MIDIParseError.invalidTrack }
            let trackLength = Int(reader.readUInt32())
            let trackEnd = reader.offset + trackLength

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
                            bpm = 60_000_000.0 / Double(microsPerBeat)
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
                            notes.append(PlayedNote(
                                pitch: pitch,
                                startBeat: Double(startTicks) / ticksPerBeat,
                                duration: max(Double(ticks - startTicks) / ticksPerBeat, 0.1),
                                hand: hand
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
        }

        notes.sort { $0.startBeat < $1.startBeat }
        return Arrangement(notes: notes, bpm: bpm)
    }
}

/// MIDIバイナリデータを先頭から順に読み進めるヘルパー
private struct MIDIByteReader {
    let data: Data
    private(set) var offset = 0

    init(data: Data) { self.data = data }

    mutating func readByte() -> UInt8 {
        let byte = data[data.startIndex + offset]
        offset += 1
        return byte
    }

    func peekByte() -> UInt8 {
        data[data.startIndex + offset]
    }

    mutating func readBytes(count: Int) -> [UInt8] {
        let start = data.startIndex + offset
        let result = Array(data[start..<start + count])
        offset += count
        return result
    }

    mutating func readString(length: Int) -> String {
        String(decoding: readBytes(count: length), as: UTF8.self)
    }

    mutating func readUInt16() -> UInt16 {
        let bytes = readBytes(count: 2)
        return (UInt16(bytes[0]) << 8) | UInt16(bytes[1])
    }

    mutating func readUInt32() -> UInt32 {
        let bytes = readBytes(count: 4)
        return (UInt32(bytes[0]) << 24) | (UInt32(bytes[1]) << 16) | (UInt32(bytes[2]) << 8) | UInt32(bytes[3])
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
