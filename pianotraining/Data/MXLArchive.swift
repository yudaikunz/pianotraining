import Foundation
import Compression

/// `.mxl`（ZIP圧縮されたMusicXML）から本体のスコアXMLを取り出す最小限のZIPリーダー。
///
/// 外部ライブラリを使わず、Foundation と Compression フレームワークだけで実装している。
/// ZIPのセントラルディレクトリを読み、各エントリのDEFLATEデータを展開する。
/// `.mxl` は通常以下の構成になっている:
///   - `META-INF/container.xml` … `<rootfile full-path="...">` で本体XMLを指す
///   - 本体の `*.xml`（例: `score.xml`）
enum MXLArchive {

    /// .mxl の生データを展開し、中の主要なMusicXML（score）の生データを返す。
    static func extractScoreXML(from data: Data) -> Data? {
        let bytes = [UInt8](data)
        let entries = readCentralDirectory(bytes)
        guard !entries.isEmpty else { return nil }

        // container.xml の rootfile が指すファイルを最優先で取り出す
        if let container = entries.first(where: { $0.name == "META-INF/container.xml" }),
           let xmlData = inflate(entry: container, from: bytes),
           let rootPath = rootfilePath(in: xmlData),
           let scoreEntry = entries.first(where: { $0.name == rootPath }),
           let score = inflate(entry: scoreEntry, from: bytes) {
            return score
        }

        // フォールバック: META-INF以外で最初に見つかった .xml を本体とみなす
        if let scoreEntry = entries.first(where: {
            $0.name.hasSuffix(".xml") && !$0.name.hasPrefix("META-INF")
        }), let score = inflate(entry: scoreEntry, from: bytes) {
            return score
        }
        return nil
    }

    // MARK: - ZIP 構造の解析

    private struct Entry {
        let name: String
        let method: Int          // 0 = 無圧縮 / 8 = DEFLATE
        let compressedSize: Int
        let uncompressedSize: Int
        let localHeaderOffset: Int
    }

    /// End Of Central Directory を見つけ、セントラルディレクトリの全エントリを読む
    private static func readCentralDirectory(_ b: [UInt8]) -> [Entry] {
        guard b.count >= 22 else { return [] }
        let eocdSignature = 0x06054b50
        // EOCDは末尾（最大22+コメント長）にある。後ろから署名を探す
        var eocd = -1
        var i = b.count - 22
        let lowerBound = max(0, b.count - 22 - 0xFFFF)
        while i >= lowerBound {
            if u32(b, i) == eocdSignature { eocd = i; break }
            i -= 1
        }
        guard eocd >= 0 else { return [] }

        let entryCount = u16(b, eocd + 10)
        var offset = u32(b, eocd + 16)   // セントラルディレクトリの開始位置

        var entries: [Entry] = []
        let centralSignature = 0x02014b50
        for _ in 0..<entryCount {
            guard offset + 46 <= b.count, u32(b, offset) == centralSignature else { break }
            let method = u16(b, offset + 10)
            let compressedSize = u32(b, offset + 20)
            let uncompressedSize = u32(b, offset + 24)
            let nameLen = u16(b, offset + 28)
            let extraLen = u16(b, offset + 30)
            let commentLen = u16(b, offset + 32)
            let localOffset = u32(b, offset + 42)

            let nameStart = offset + 46
            guard nameStart + nameLen <= b.count else { break }
            let name = String(decoding: b[nameStart..<nameStart + nameLen], as: UTF8.self)

            entries.append(Entry(name: name, method: method,
                                 compressedSize: compressedSize,
                                 uncompressedSize: uncompressedSize,
                                 localHeaderOffset: localOffset))
            offset = nameStart + nameLen + extraLen + commentLen
        }
        return entries
    }

    /// エントリのローカルヘッダからデータ本体を取り出し、必要なら展開して返す
    private static func inflate(entry: Entry, from b: [UInt8]) -> Data? {
        let lo = entry.localHeaderOffset
        let localSignature = 0x04034b50
        guard lo + 30 <= b.count, u32(b, lo) == localSignature else { return nil }

        // ローカルヘッダのファイル名長・拡張領域長はセントラルと異なる場合があるので必ずここで読む
        let nameLen = u16(b, lo + 26)
        let extraLen = u16(b, lo + 28)
        let dataStart = lo + 30 + nameLen + extraLen
        guard dataStart + entry.compressedSize <= b.count else { return nil }

        let compressed = Array(b[dataStart..<dataStart + entry.compressedSize])

        if entry.method == 0 {
            return Data(compressed)               // 無圧縮（stored）
        }
        guard entry.method == 8 else { return nil } // DEFLATE以外は未対応
        return rawInflate(compressed, expectedSize: entry.uncompressedSize)
    }

    /// ZIP標準のraw DEFLATEストリームを Compression フレームワークで展開する
    private static func rawInflate(_ source: [UInt8], expectedSize: Int) -> Data? {
        guard expectedSize > 0 else { return nil }
        var output = Data(count: expectedSize)
        let written = output.withUnsafeMutableBytes { dst -> Int in
            source.withUnsafeBufferPointer { src -> Int in
                guard let dstBase = dst.bindMemory(to: UInt8.self).baseAddress,
                      let srcBase = src.baseAddress else { return 0 }
                // COMPRESSION_ZLIB はzlibヘッダ無しのraw DEFLATEを展開する（ZIPと一致）
                return compression_decode_buffer(dstBase, expectedSize,
                                                 srcBase, source.count,
                                                 nil, COMPRESSION_ZLIB)
            }
        }
        guard written > 0 else { return nil }
        return written == expectedSize ? output : output.prefix(written)
    }

    /// container.xml から本体XMLのパス（rootfile full-path）を取り出す
    private static func rootfilePath(in data: Data) -> String? {
        guard let xml = String(data: data, encoding: .utf8),
              let range = xml.range(of: "full-path=\"") else { return nil }
        let rest = xml[range.upperBound...]
        guard let end = rest.firstIndex(of: "\"") else { return nil }
        return String(rest[..<end])
    }

    // MARK: - リトルエンディアン読み出し

    private static func u16(_ b: [UInt8], _ i: Int) -> Int {
        guard i + 1 < b.count else { return 0 }
        return Int(b[i]) | Int(b[i + 1]) << 8
    }

    private static func u32(_ b: [UInt8], _ i: Int) -> Int {
        guard i + 3 < b.count else { return 0 }
        return Int(b[i]) | Int(b[i + 1]) << 8 | Int(b[i + 2]) << 16 | Int(b[i + 3]) << 24
    }
}
