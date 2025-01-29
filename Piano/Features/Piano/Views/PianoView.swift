import SwiftUI

struct PianoKeyShape: Shape {
    let isBlackKey: Bool
    let cornerRadius: CGFloat = 8
    
    func path(in rect: CGRect) -> Path {
        UnevenRoundedRectangle(
            bottomLeadingRadius: cornerRadius,
            bottomTrailingRadius: cornerRadius
        ).path(in: rect)
    }
}

extension View {
    var whiteKeyWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32
        return availableWidth / 7
    }
    
    func whiteKey(_ midiNote: Int, label: String, showLabels: Bool) -> some View {
        NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: .constant(false)
            ),
            style: NoteButtonStyle(
                inactiveColor: .white,
                overlayColor: .black,
                overlayOpacity: 0.2,
                hapticStyle: .rigid,
                hapticIntensity: 0.67,
                shape: { rect in
                    PianoKeyShape(isBlackKey: false).path(in: rect)
                },
                shadowEnabled: true,
                label: {
                    Group {
                        if showLabels {
                            VStack {
                                Spacer()
                                Text(label)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .fontDesign(.rounded)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 13)
                            }
                        }
                    }
                }
            )
        )
        .frame(width: whiteKeyWidth)
    }

    func blackKey(_ midiNote: Int, label: String, showLabels: Bool) -> some View {
        let blackKeyWidth = whiteKeyWidth * 0.65
        
        return NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: .constant(false)
            ),
            style: NoteButtonStyle(
                inactiveColor: .black,
                overlayColor: .white,
                overlayOpacity: 0.2,
                hapticStyle: .rigid,
                hapticIntensity: 0.67,
                shape: { rect in
                    PianoKeyShape(isBlackKey: true).path(in: rect)
                },
                shadowEnabled: true,
                label: {
                    Group {
                        if showLabels {
                            VStack {
                                Spacer()
                                Text(label)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color(.systemGray2))
                                    .padding(.bottom, 11.5)
                            }
                        }
                    }
                }
            )
        )
        .frame(width: blackKeyWidth)
    }
}

struct KeySegment: View {
    let whiteNotes: [Int]  // Array of MIDI notes for white keys
    let blackNotes: [Int]  // Array of MIDI notes for black keys
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
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

// Then we can define our segments like this:
extension KeySegment {
    static func ceSegment(baseC: Int, showLabels: Bool, labelSystem: MusicTheory.LabelSystem) -> KeySegment {
        KeySegment(
            whiteNotes: [baseC + 0, baseC + 2, baseC + 4],
            blackNotes: [baseC + 1, baseC + 3],
            showLabels: showLabels,
            labelSystem: labelSystem
        )
    }
    
    static func fbSegment(baseC: Int, showLabels: Bool, labelSystem: MusicTheory.LabelSystem) -> KeySegment {
        KeySegment(
            whiteNotes: [baseC + 5, baseC + 7, baseC + 9, baseC + 11],
            blackNotes: [baseC + 6, baseC + 8, baseC + 10],
            showLabels: showLabels,
            labelSystem: labelSystem
        )
    }
    
    static func lowerFBSegment(baseC: Int, showLabels: Bool, labelSystem: MusicTheory.LabelSystem) -> KeySegment {
        KeySegment(
            whiteNotes: [baseC - 7, baseC - 5, baseC - 3, baseC - 1],
            blackNotes: [baseC - 6, baseC - 4, baseC - 2],
            showLabels: showLabels,
            labelSystem: labelSystem
        )
    }
    
    static func upperCESegment(baseC: Int, showLabels: Bool, labelSystem: MusicTheory.LabelSystem) -> KeySegment {
        KeySegment(
            whiteNotes: [baseC + 12, baseC + 14, baseC + 16],
            blackNotes: [baseC + 13, baseC + 15],
            showLabels: showLabels,
            labelSystem: labelSystem
        )
    }
}

struct PianoRegisterView: View {
    let baseC: Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            KeySegment.ceSegment(baseC: baseC, showLabels: showLabels, labelSystem: labelSystem)
            KeySegment.fbSegment(baseC: baseC, showLabels: showLabels, labelSystem: labelSystem)
        }
        .padding(.horizontal, 4)
    }
}

struct PianoView: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        VStack(spacing: 10) {
            PianoRegisterView(
                baseC: 72,  // C5
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            PianoRegisterView(
                baseC: 60,  // C4
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            PianoRegisterView(
                baseC: 48,  // C3
                showLabels: showLabels,
                labelSystem: labelSystem
            )
        }
    }

    static func lowerFBSegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([53, 55, 57, 59], [54, 56, 58])  // F3-B3
    }
    
    static func lowerCESegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([60, 62, 64], [61, 63])  // C4-E4
    }

    static func upperFBSegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([65, 67, 69, 71], [66, 68, 70])  // F4-B4
    }
    
    static func upperCESegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([72, 74, 76], [73, 75])  // C5-E5
    }
}

#Preview {
    return PianoView(
        showLabels: true,
        labelSystem: .none
    )
} 
