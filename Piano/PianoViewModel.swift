import SwiftUI

struct PianoKey: Identifiable {
    let id = UUID()
    let midiNote: Int
    let label: String
    let isBlack: Bool
    let segment: PianoSegment
}

enum PianoSegment {
    case ce
    case fb
}

class PianoViewModel: ObservableObject {
    @Published var keys: [PianoKey] = []
    
    init(startingNote: Int) {
        // Validate that startingNote is a C (must be divisible by 12)
        assert(startingNote % 12 == 0, "Starting note must be a C")
        
        // CE Segment
        keys += [
            PianoKey(midiNote: startingNote + 0, label: "C", isBlack: false, segment: .ce),
            PianoKey(midiNote: startingNote + 1, label: "C#", isBlack: true, segment: .ce),
            PianoKey(midiNote: startingNote + 2, label: "D", isBlack: false, segment: .ce),
            PianoKey(midiNote: startingNote + 3, label: "D#", isBlack: true, segment: .ce),
            PianoKey(midiNote: startingNote + 4, label: "E", isBlack: false, segment: .ce),
        ]
        
        // FB Segment
        keys += [
            PianoKey(midiNote: startingNote + 5, label: "F", isBlack: false, segment: .fb),
            PianoKey(midiNote: startingNote + 6, label: "F#", isBlack: true, segment: .fb),
            PianoKey(midiNote: startingNote + 7, label: "G", isBlack: false, segment: .fb),
            PianoKey(midiNote: startingNote + 8, label: "G#", isBlack: true, segment: .fb),
            PianoKey(midiNote: startingNote + 9, label: "A", isBlack: false, segment: .fb),
            PianoKey(midiNote: startingNote + 10, label: "A#", isBlack: true, segment: .fb),
            PianoKey(midiNote: startingNote + 11, label: "B", isBlack: false, segment: .fb),
        ]
    }
    
    var ceSegmentKeys: [PianoKey] {
        keys.filter { $0.segment == .ce }
    }
    
    var fbSegmentKeys: [PianoKey] {
        keys.filter { $0.segment == .fb }
    }
    
    var whiteKeys: [PianoKey] {
        keys.filter { !$0.isBlack }
    }
    
    var blackKeys: [PianoKey] {
        keys.filter { $0.isBlack }
    }
} 