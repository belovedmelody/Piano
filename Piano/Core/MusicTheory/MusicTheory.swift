import Foundation

enum MusicTheory {
    enum Tonic: Int, CaseIterable {
        case f_lower = 0  // F3
        case g_flat, g, a_flat, a, b_flat, b, c, d_flat, d, e_flat, e, f  // to F4
        
        private static let names = ["F₃", "G♭", "G", "A♭", "A", "B♭", "B", "C", "D♭", "D", "E♭", "E", "F₄"]
        
        var rawDisplayName: String {
            Self.names[rawValue]
        }
        
        var midiNumber: Int {
            rawValue + 53  // F3 starts at MIDI 53
        }
    }
    
    // Major scale pattern as intervals from tonic
    static let majorScaleIntervals = [0, 2, 4, 5, 7, 9, 11]
    
    // Display names for notes (already have these)
    static let sharpPitchDisplayNames = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    static let flatPitchDisplayNames = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "C♭"]
    static let naturalDisplayNames = ["C", "", "D", "", "E", "F", "", "G", "", "A", "", "B"]
    
    enum LabelSystem {
        case sharps
        case flats
        case naturals
        case none
    }

    // Helper to determine if a tonic uses flats
    static func usesFlats(_ tonic: Tonic) -> Bool {
        switch tonic {
        case .f_lower, .b_flat, .e_flat, .a_flat, .d_flat, .g_flat, .f:
            return true
        default:
            return false
        }
    }
    
    // Get the appropriate label system for a tonic
    static func labelSystemForTonic(_ tonic: Tonic) -> LabelSystem {
        usesFlats(tonic) ? .flats : .sharps
    }

    // Keep the original style-based naming for PianoView
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

    // Add the new tonic-based naming for ScaleView
    static func noteName(for midiNumber: Int, tonic: Tonic) -> String {
        let pitchClass = midiNumber % 12
        return usesFlats(tonic) ? flatPitchDisplayNames[pitchClass] : sharpPitchDisplayNames[pitchClass]
    }

    // Build a major scale starting from a given MIDI note number
    static func majorScale(fromMidiNumber midiNumber: Int) -> [Int] {
        majorScaleIntervals.map { midiNumber + $0 }
    }
    
    // Get the scale for a specific register (octave)
    static func majorScaleRegister(tonic: Tonic, register: Int) -> [Int] {
        // Start from one octave below the tonic's default MIDI number
        let baseMidiNumber = (tonic.midiNumber - 12) + (register * 12)
        return majorScale(fromMidiNumber: baseMidiNumber)
    }
    
    // Get all three registers for ScaleView
    static func scaleRegisters(tonic: Tonic) -> [[Int]] {
        [
            majorScaleRegister(tonic: tonic, register: 2),  // High register (C6)
            majorScaleRegister(tonic: tonic, register: 1),  // Middle register (C5)
            majorScaleRegister(tonic: tonic, register: 0)   // Low register (C4)
        ]
    }

    static func isAccidental(_ midiNumber: Int) -> Bool {
        let pitchClass = midiNumber % 12
        return [1, 3, 6, 8, 10].contains(pitchClass)  // C#/Db, D#/Eb, F#/Gb, G#/Ab, A#/Bb
    }
} 