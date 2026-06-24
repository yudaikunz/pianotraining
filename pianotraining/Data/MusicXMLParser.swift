import Foundation

/// MusicXML（楽譜の標準デジタル形式）を読み込み、演奏データ（Arrangement）に変換するパーサー。
///
/// MusicXMLはMIDIと違い、楽譜として本質的な情報を明示的に持っている:
///   - `<staff>` で右手（staff 1＝ト音記号）／左手（staff 2＝ヘ音記号）が確定する（推測不要）
///   - `<step>` `<alter>` `<octave>` で正しい音名（シャープ/フラット/ナチュラルの区別）が分かる
///   - `<divisions>` を基準に小節・拍・音価が正確に表現される
///
/// 本実装は score-partwise 形式の MusicXML に対応する。
/// 非圧縮（.musicxml / .xml）に加え、圧縮形式（.mxl）も `MXLArchive` で展開して読み込む。
struct MusicXMLParser {

    /// アプリにバンドルされたMusicXMLファイルを読み込んで演奏データに変換する。
    /// `.musicxml` / `.xml`（非圧縮）を優先し、無ければ `.mxl`（ZIP圧縮）を展開して読む。
    /// 該当ファイルが存在しない場合は他の形式へのフォールバックなので無音で nil を返すが、
    /// ファイルは存在するのに読み込み・解析に失敗した場合はログを出す（バンドル不備の早期発見用）。
    static func loadArrangement(resourceName: String) -> Arrangement? {
        if let url = Bundle.main.url(forResource: resourceName, withExtension: "musicxml")
            ?? Bundle.main.url(forResource: resourceName, withExtension: "xml") {
            guard let data = try? Data(contentsOf: url) else {
                print("MusicXML読み込み失敗: \(resourceName) のファイルを読み込めませんでした")
                return nil
            }
            return parse(data: data, source: resourceName)
        }
        if let url = Bundle.main.url(forResource: resourceName, withExtension: "mxl") {
            guard let zipped = try? Data(contentsOf: url) else {
                print("MXL読み込み失敗: \(resourceName) のファイルを読み込めませんでした")
                return nil
            }
            guard let data = MXLArchive.extractScoreXML(from: zipped) else {
                print("MXL展開失敗: \(resourceName) から楽譜XMLを取り出せませんでした")
                return nil
            }
            return parse(data: data, source: resourceName)
        }
        return nil
    }

    static func parse(data: Data, source: String = "MusicXML") -> Arrangement? {
        let parser = XMLParser(data: data)
        let delegate = MusicXMLParserDelegate()
        parser.delegate = delegate
        guard parser.parse() else {
            let detail = parser.parserError?.localizedDescription ?? "不明なエラー"
            print("MusicXML解析失敗 (\(source)): \(detail)（\(parser.lineNumber)行目）")
            return nil
        }

        let notes = delegate.notes.sorted { $0.startBeat < $1.startBeat }
        guard !notes.isEmpty else {
            print("MusicXML解析警告 (\(source)): 音符データが見つかりませんでした")
            return nil
        }
        return Arrangement(notes: notes, bpm: delegate.bpm, beatsPerMeasure: delegate.beatsPerMeasure)
    }
}

/// XMLParser（SAX形式）のイベントを受け取り、音符を組み立てるデリゲート。
private final class MusicXMLParserDelegate: NSObject, XMLParserDelegate {
    private(set) var notes: [PlayedNote] = []
    private(set) var bpm: Double = 120
    /// 1小節分の長さ（4分音符換算の拍数。例: 3/4なら3.0、3/8なら1.5）
    private(set) var beatsPerMeasure: Double = 4
    // Arrangementは単一テンポ・単一拍子として扱うため、最初に出てきた値だけを採用する
    private var bpmLocked = false
    private var timeSignatureLocked = false
    private var timeBeats: Int?
    private var timeBeatType: Int?

    // 楽譜全体の進行状態
    private var divisions = 1          // 4分音符あたりの分解能
    private var position = 0           // 現在の時間位置（divisions単位、小節をまたいで連続）
    private var lastNoteStartPos = 0   // 直前の音符の開始位置（chord＝同時和音の起点に使う）

    // 現在パース中の <note> の一時データ
    private var step: String?
    private var alter = 0
    private var octave: Int?
    private var noteDuration = 0
    private var isChord = false
    private var isRest = false
    private var staff = 1

    // <backup> / <forward>（複数譜表を行き来するための時間移動）
    private enum DurationTarget { case note, backup, forward }
    private var durationTarget: DurationTarget = .note
    private var backupDuration = 0
    private var forwardDuration = 0

    private var buffer = ""

    private static let stepSemitones: [String: Int] =
        ["C": 0, "D": 2, "E": 4, "F": 5, "G": 7, "A": 9, "B": 11]

    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String: String]) {
        buffer = ""

        switch elementName {
        case "note":
            step = nil
            alter = 0
            octave = nil
            noteDuration = 0
            isChord = false
            isRest = false
            staff = 1
            durationTarget = .note
        case "chord":
            isChord = true
        case "rest":
            isRest = true
        case "backup":
            durationTarget = .backup
            backupDuration = 0
        case "forward":
            durationTarget = .forward
            forwardDuration = 0
        case "sound":
            if let tempo = attributeDict["tempo"], let value = Double(tempo) {
                setInitialTempo(value)
            }
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        buffer += string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        let text = buffer.trimmingCharacters(in: .whitespacesAndNewlines)

        switch elementName {
        case "divisions":
            if let value = Int(text) { divisions = max(value, 1) }
        case "step":
            step = text
        case "alter":
            alter = Int(text) ?? 0
        case "octave":
            octave = Int(text)
        case "beats":
            if !timeSignatureLocked { timeBeats = Int(text) }
        case "beat-type":
            if !timeSignatureLocked { timeBeatType = Int(text) }
        case "time":
            if !timeSignatureLocked, let beats = timeBeats, let beatType = timeBeatType,
               beats > 0, beatType > 0 {
                // 4分音符を1拍として換算した1小節分の長さ（例: 3/8拍子 → 3 × 4/8 = 1.5）
                beatsPerMeasure = Double(beats) * 4.0 / Double(beatType)
                timeSignatureLocked = true
            }
        case "staff":
            staff = Int(text) ?? 1
        case "duration":
            let value = Int(text) ?? 0
            switch durationTarget {
            case .note:    noteDuration = value
            case .backup:  backupDuration = value
            case .forward: forwardDuration = value
            }
        case "note":
            finalizeNote()
        case "backup":
            position = max(position - backupDuration, 0)
        case "forward":
            position += forwardDuration
        case "per-minute":
            if let value = Double(text) { setInitialTempo(value) }
        default:
            break
        }

        buffer = ""
    }

    /// 最初に出てきたテンポ指定だけを採用する（以降の rit. / accel. 等は無視）
    private func setInitialTempo(_ value: Double) {
        guard !bpmLocked, value > 0 else { return }
        bpm = value
        bpmLocked = true
    }

    /// 1つの <note> を読み終えたタイミングで、音符を確定して時間位置を進める
    private func finalizeNote() {
        let startPos: Int
        if isChord {
            // 和音の構成音：直前の音符と同時に鳴る。時間位置は進めない
            startPos = lastNoteStartPos
        } else {
            startPos = position
            lastNoteStartPos = position
            position += noteDuration
        }

        guard !isRest, let step, let octave,
              let semitone = Self.stepSemitones[step] else { return }

        let pitch = (octave + 1) * 12 + semitone + alter
        notes.append(PlayedNote(
            pitch: pitch,
            startBeat: Double(startPos) / Double(divisions),
            duration: max(Double(noteDuration) / Double(divisions), 0.1),
            hand: staff == 2 ? .left : .right
        ))
    }
}
