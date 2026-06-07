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

    var whiteKeyPitches: [Int] {
        var result: [Int] = []
        for octave in 0..<octaveCount {
            for offset in Self.whiteOffsets {
                result.append(lowestPitch + octave * 12 + offset)
            }
        }
        result.append(lowestPitch + octaveCount * 12)
        return result
    }

    var blackKeyPitches: [(pitch: Int, whiteIndexBefore: Int)] {
        var result: [(Int, Int)] = []
        for octave in 0..<octaveCount {
            for entry in Self.blackOffsets {
                let pitch = lowestPitch + octave * 12 + entry.offset
                guard let whiteIndex = Self.whiteOffsets.firstIndex(of: entry.afterWhiteOffset) else { continue }
                result.append((pitch, octave * 7 + whiteIndex))
            }
        }
        return result
    }

    /// 指定したMIDIノート番号の鍵盤上での中心x座標
    func centerX(for pitch: Int) -> CGFloat {
        let pitchClass = ((pitch - lowestPitch) % 12 + 12) % 12
        let octave = (pitch - lowestPitch - pitchClass) / 12

        if let whiteOffsetIndex = Self.whiteOffsets.firstIndex(of: pitchClass) {
            let whiteIndex = octave * 7 + whiteOffsetIndex
            return (CGFloat(whiteIndex) + 0.5) * whiteKeyWidth
        }
        if let entry = Self.blackOffsets.first(where: { $0.offset == pitchClass }),
           let whiteOffsetIndex = Self.whiteOffsets.firstIndex(of: entry.afterWhiteOffset) {
            let whiteIndex = octave * 7 + whiteOffsetIndex
            return CGFloat(whiteIndex + 1) * whiteKeyWidth
        }
        return width / 2
    }

    /// 指定した音が白鍵かどうか
    func isWhiteKey(_ pitch: Int) -> Bool {
        let pitchClass = ((pitch - lowestPitch) % 12 + 12) % 12
        return Self.whiteOffsets.contains(pitchClass)
    }
}
