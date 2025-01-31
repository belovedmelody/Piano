import SwiftUI

extension View {
    var whiteKeyWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32
        return availableWidth / 7
    }
}

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

enum KeySegmentType {
    case ce(baseC: Int)      // C to E segment
    case fb(baseC: Int)      // F to B segment
    case lowerFB(baseC: Int) // Lower F to B segment
    case upperCE(baseC: Int) // Upper C to E segment
    
    var notes: (whiteKeys: [Int], blackKeys: [Int]) {
        switch self {
        case .ce(let baseC):
            return ([baseC + 0, baseC + 2, baseC + 4],
                   [baseC + 1, baseC + 3])
        case .fb(let baseC):
            return ([baseC + 5, baseC + 7, baseC + 9, baseC + 11],
                   [baseC + 6, baseC + 8, baseC + 10])
        case .lowerFB(let baseC):
            return ([baseC - 7, baseC - 5, baseC - 3, baseC - 1],
                   [baseC - 6, baseC - 4, baseC - 2])
        case .upperCE(let baseC):
            return ([baseC + 12, baseC + 14, baseC + 16],
                   [baseC + 13, baseC + 15])
        }
    }
}

extension KeySegment {
    static func segment(_ type: KeySegmentType, showLabels: Bool, labelSystem: MusicTheory.LabelSystem) -> KeySegment {
        let notes = type.notes
        return KeySegment(
            whiteNotes: notes.whiteKeys,
            blackNotes: notes.blackKeys,
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
            KeySegment.segment(.ce(baseC: baseC), showLabels: showLabels, labelSystem: labelSystem)
            KeySegment.segment(.fb(baseC: baseC), showLabels: showLabels, labelSystem: labelSystem)
        }
        .padding(.horizontal, 4)
    }
} 