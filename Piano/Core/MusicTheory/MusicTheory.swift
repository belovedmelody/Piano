import Foundation

enum MusicTheory {
    // Major scale pattern as boolean mask (true = in scale)
    static let majorScalePattern: [Bool] = [
        true,  // Root (0)
        false, // ♭2/♯1
        true,  // 2
        false, // ♭3/♯2
        true,  // 3
        true,  // 4
        false, // ♭5/♯4
        true,  // 5
        false, // ♭6/♯5
        true,  // 6
        false, // ♭7/♯6
        true   // 7
    ]

    enum Tonic: String, CaseIterable {
        case f = "f"  // Lower F
        case G_flat = "G♭"
        case G = "G"
        case A_flat = "A♭"
        case A = "A"
        case B_flat = "B♭"
        case B = "B"
        case C = "C"
        case D_flat = "D♭"
        case D = "D"
        case E_flat = "E♭"
        case E = "E"
        case F = "F"  // Upper F
        
        var midiNumber: Int {
            switch self {
            case .f: return 53      // Lower F
            case .G_flat: return 54
            case .G: return 55
            case .A_flat: return 56
            case .A: return 57
            case .B_flat: return 58
            case .B: return 59
            case .C: return 60
            case .D_flat: return 61
            case .D: return 62
            case .E_flat: return 63
            case .E: return 64
            case .F: return 65      // Upper F
            }
        }
    }

    static let sharpPitchDisplayNames = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    static let flatPitchDisplayNames = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
    static let naturalDisplayNames = ["C", "", "D", "", "E", "F", "", "G", "", "A", "", "B"]
    
    enum LabelSystem {
        case sharps
        case flats
        case naturals
        case none
    }

    static func noteName(for midiNumber: Int, style: LabelSystem) -> String {
        let pitchClass = midiNumber % 12
        switch style {
        case .sharps:
            return sharpPitchDisplayNames[pitchClass]
        case .flats:
            return flatPitchDisplayNames[pitchClass]
        case .naturals:
            return naturalDisplayNames[pitchClass]
        case .none:
            return ""
        }
    }
} 