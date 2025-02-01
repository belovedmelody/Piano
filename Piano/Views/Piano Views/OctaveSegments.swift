// Piano keys have a very specific layout, made of two ergonomic symmetrical segments.
// CE is the three-note segment; FB is the four-note.

import SwiftUI

enum OctaveSegmentType {
    case c(baseC: Int)  // Must start on C
    case f(baseF: Int)  // Must start on F
    
    var segmentName: String {
        switch self {
        case .c(let baseC): return "CSegment(\(baseC))"
        case .f(let baseF): return "FSegment(\(baseF))"
        }
    }
    
    var notes: (whiteKeys: [Int], blackKeys: [Int]) {
        switch self {
        case .c(let baseC):
            // C through E
            return ([baseC + 0, baseC + 2, baseC + 4],     // C, D, E
                   [baseC + 1, baseC + 3])                 // C#, D#
        case .f(let baseF):
            // F through B
            return ([baseF + 0, baseF + 2, baseF + 4, baseF + 6],  // F, G, A, B
                   [baseF + 1, baseF + 3, baseF + 5])              // F#, G#, A#
        }
    }
}

struct OctaveSegment: View {
    let whiteNotes: [Int]
    let blackNotes: [Int]
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    init(type: OctaveSegmentType, showLabels: Bool, labelSystem: MusicTheory.LabelSystem) {
        let notes = type.notes
        self.whiteNotes = notes.whiteKeys
        self.blackNotes = notes.blackKeys
        self.showLabels = showLabels
        self.labelSystem = labelSystem
    }
    
    var body: some View {
        ZStack {
            // White keys layer
            HStack(spacing: 4) {
                ForEach(whiteNotes, id: \.self) { note in
                    whiteKey(note,
                            label: MusicTheory.noteName(for: note, style: labelSystem),
                            showLabels: showLabels)
                }
            }
            
            // Black keys layer
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: whiteKeyWidth * 0.65)
                        ForEach(Array(blackNotes.enumerated()), id: \.element) { index, note in
                            blackKey(note,
                                    label: MusicTheory.noteName(for: note, style: labelSystem),
                                    showLabels: showLabels)
                            if index < blackNotes.count - 1 {
                                Spacer()
                            }
                        }
                        Spacer()
                            .frame(width: whiteKeyWidth * 0.65)
                    }
                    Spacer()
                        .frame(height: geometry.size.height * 0.4)
                }
            }
        }
    }
}

#Preview {
    let _ = {
        print("\nExpected segment layout:")
        print("octave view = ", terminator: "")
        print("CSegment(84)", terminator: "")
        print("+", terminator: "")
        print("FSegment(89)")
    }()
    
    HStack(spacing: 4) {
        OctaveSegment(
            type: .c(baseC: 84),  // F5
            showLabels: true,
            labelSystem: .naturals
        )
        OctaveSegment(
            type: .f(baseF: 89),  // C6
            showLabels: true,
            labelSystem: .naturals
        )
    }
    .padding(.horizontal, 4)
    .padding()
} 
