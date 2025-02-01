// An assembler for piano views to be modified by offsets according to the tonic

import SwiftUI
// No need for additional imports since OctaveParts is in the same module

struct ExtendedOctaveView: View {
    let tonic: Int  // Changed from MusicTheory.Tonic to Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    @State private var keyBoundaries: [KeyBoundaries] = []
    
    private func determineSegments() -> [OctaveSegmentType] {
        let scaleNotes = MusicTheory.majorScale(fromMidiNumber: tonic)  // Now we can use tonic directly
        
        // Find the octave boundaries
//        let lowestNote = scaleNotes.min()!
//        let highestNote = scaleNotes.max()!
        
        // Find which segments contain our scale notes
        var segments: [OctaveSegmentType] = []
        
        // For each note in the scale
        for note in scaleNotes {
            let baseC = note - (note % 12)  // Find the C for this note's octave
            
            if note % 12 <= 4 {  // Note is C through E
                if !segments.contains(where: { 
                    if case .c(let c) = $0 { return c == baseC }
                    return false 
                }) {
                    segments.append(.c(baseC: baseC))
                }
            } else {  // Note is F through B
                if !segments.contains(where: { 
                    if case .f(let f) = $0 { return f == baseC + 5 }
                    return false 
                }) {
                    segments.append(.f(baseF: baseC + 5))
                }
            }
        }
        
        // Sort segments by their base note
        segments.sort { a, b in
            switch (a, b) {
            case (.c(let c1), .c(let c2)): return c1 < c2
            case (.f(let f1), .f(let f2)): return f1 < f2
            case (.c(let c), .f(let f)): return c < f
            case (.f(let f), .c(let c)): return f < c
            }
        }
        
        return segments
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 4) {
                ForEach(determineSegments(), id: \.segmentName) { segment in
                    OctaveSegment(
                        type: segment,
                        showLabels: showLabels,
                        labelSystem: labelSystem
                    )
                }
            }
            .padding(.horizontal, 4)
            
            // Debug overlay
            ForEach(keyBoundaries, id: \.keyIndex) { boundary in
                // Left edge markers in red
                Rectangle()
                    .fill(.red.opacity(0.3))
                    .frame(width: 2)
                    .position(x: boundary.leftEdge, y: 50)
                
                // Right edge markers in blue
                Rectangle()
                    .fill(.blue.opacity(0.3))
                    .frame(width: 2)
                    .position(x: boundary.rightEdge, y: 50)
            }
        }
        .onPreferenceChange(KeyBoundaryPreferenceKey.self) { boundaries in
            keyBoundaries = boundaries.sorted { $0.keyIndex < $1.keyIndex }
            print("Collected boundaries: \(boundaries)")  // Debug print
        }
    }
}

#Preview {
    let _ = {
        print("\nExpected layouts for different tonics:")
        print("\nC major:")
        print("extended octave view = CSegment(60)+FSegment(65)")
        print("\nF major:")
        print("extended octave view = FSegment(65)+CSegment(72)")
        print("\nE major:")
        print("extended octave view = CSegment(60)+FSegment(65)+CSegment(72)")
        print("\nB major:")
        print("extended octave view = FSegment(71)+CSegment(84)+FSegment(89)")
    }()
    
    VStack(spacing: 20) {
        // Test C major
        ExtendedOctaveView(
            tonic: 60,
            showLabels: true,
            labelSystem: .naturals
        )
        
        // Test F major
        ExtendedOctaveView(
            tonic: 65,
            showLabels: true,
            labelSystem: .naturals
        )
        
        // Test E major
        ExtendedOctaveView(
            tonic: 72,
            showLabels: true,
            labelSystem: .naturals
        )
        
        // Test B major
        ExtendedOctaveView(
            tonic: 84,
            showLabels: true,
            labelSystem: .naturals
        )
    }
    .padding()
} 
