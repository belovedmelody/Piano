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
        case C, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B
        
        var midiNumber: Int {
            switch self {
            case .C: return 60
            case .Db: return 61
            case .D: return 62
            case .Eb: return 63
            case .E: return 64
            case .F: return 65
            case .Gb: return 66
            case .G: return 67
            case .Ab: return 68
            case .A: return 69
            case .Bb: return 70
            case .B: return 71
            }
        }
    }
} 