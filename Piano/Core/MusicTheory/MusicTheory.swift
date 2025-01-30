import Foundation

enum MusicTheory {
    enum Tonic: Int, CaseIterable {
        case c = 0      // C4 (MIDI 60)
        case c_sharp, d, d_sharp, e, f, f_sharp, g, g_sharp, a, a_sharp, b, c_upper
        
        private static let names = ["C₄", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B", "C₅"]
        
        var rawDisplayName: String {
            Self.names[rawValue]
        }
        
        var midiNumber: Int {
            rawValue + 60  // C4 starts at MIDI 60
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
    // ## Change this to use flat nomenclature again
    static func usesFlats(_ tonic: Tonic) -> Bool {
        switch tonic {
        case .f, .a_sharp, .d_sharp, .g_sharp, .c_sharp, .f_sharp:
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