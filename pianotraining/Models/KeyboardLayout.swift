import CoreGraphics

/// 鍵盤上の各音の横位置を計算する共通ロジック。
/// PianoKeyboardView と FallingNotesView の両方で使うことで、
/// 「落ちてくる音符」と「鍵盤」の横位置がぴったり一致するようにする。
struct KeyboardLayout {
    let lowestPitch: Int
    let octaveCount: Int
    let width: CGFloat
    let keyboardHeight: CGFloat

    private static let whiteOffsets = [0, 2, 4, 5, 7, 9, 11]
    private static let blackOffsets: [(offset: Int, afterWhiteOffset: Int)] =
        [(1, 0), (3, 2), (6, 5), (8, 7), (10, 9)]

    var whiteKeyCount: Int { octaveCount * 7 + 1 }
    var whiteKeyWidth: CGFloat { width / CGFloat(whiteKeyCount) }
    var blackKeyWidth: CGFloat { whiteKeyWidth * 0.6 }
    var blackKeyHeight: CGFloat { keyboardHeight * 0.6 }

    let whiteKeyPitches: [Int]
    let blackKeyPitches: [(pitch: Int, whiteIndexBefore: Int)]
    private let centerXCache: [Int: CGFloat]

    init(lowestPitch: Int, octaveCount: Int, width: CGFloat, keyboardHeight: CGFloat) {
        self.lowestPitch = lowestPitch
        self.octaveCount = octaveCount
        self.width = width
        self.keyboardHeight = keyboardHeight

        let whiteKeyCount = octaveCount * 7 + 1
        let whiteKeyWidth = width / CGFloat(whiteKeyCount)

        var whites: [Int] = []
        for octave in 0..<octaveCount {
            for offset in Self.whiteOffsets {
                whites.append(lowestPitch + octave * 12 + offset)
            }
        }
        whites.append(lowestPitch + octaveCount * 12)
        self.whiteKeyPitches = whites

        var blacks: [(Int, Int)] = []
        for octave in 0..<octaveCount {
            for entry in Self.blackOffsets {
                let pitch = lowestPitch + octave * 12 + entry.offset
                guard let whiteIndex = Self.whiteOffsets.firstIndex(of: entry.afterWhiteOffset) else { continue }
                blacks.append((pitch, octave * 7 + whiteIndex))
            }
        }
        self.blackKeyPitches = blacks

        var cache: [Int: CGFloat] = [:]
        cache.reserveCapacity(whites.count + blacks.count)
        for (i, pitch) in whites.enumerated() {
            cache[pitch] = (CGFloat(i) + 0.5) * whiteKeyWidth
        }
        for entry in blacks {
            cache[entry.0] = CGFloat(entry.1 + 1) * whiteKeyWidth
        }
        self.centerXCache = cache
    }

    func centerX(for pitch: Int) -> CGFloat {
        centerXCache[pitch] ?? width / 2
    }

    func isWhiteKey(_ pitch: Int) -> Bool {
        let pitchClass = ((pitch - lowestPitch) % 12 + 12) % 12
        return Self.whiteOffsets.contains(pitchClass)
    }
}
