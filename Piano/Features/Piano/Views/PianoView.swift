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
    func whiteKey(_ midiNote: Int, label: String, width: CGFloat, showLabels: Bool) -> some View {
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
        .frame(width: width)
    }

    func blackKey(_ midiNote: Int, label: String, width: CGFloat, showLabels: Bool) -> some View {
        NoteButtonView(
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
        .frame(width: width)
    }
}

struct CESegment: View {
    let whiteKeyWidth: CGFloat
    let startingNote: Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(startingNote + 0, 
                    label: MusicTheory.noteName(for: startingNote + 0, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
            whiteKey(startingNote + 2,
                    label: MusicTheory.noteName(for: startingNote + 2, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
            whiteKey(startingNote + 4,
                    label: MusicTheory.noteName(for: startingNote + 4, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
        }
    }
}

struct FBSegment: View {
    let whiteKeyWidth: CGFloat
    let startingNote: Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(startingNote + 5,
                    label: MusicTheory.noteName(for: startingNote + 5, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
            whiteKey(startingNote + 7,
                    label: MusicTheory.noteName(for: startingNote + 7, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
            whiteKey(startingNote + 9,
                    label: MusicTheory.noteName(for: startingNote + 9, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
            whiteKey(startingNote + 11,
                    label: MusicTheory.noteName(for: startingNote + 11, style: labelSystem),
                    width: whiteKeyWidth,
                    showLabels: showLabels)
        }
    }
}

struct PianoRegisterView: View {
    let startingNote: Int
    let whiteKeyWidth: CGFloat
    let blackKeyWidth: CGFloat
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                CESegment(whiteKeyWidth: whiteKeyWidth, startingNote: startingNote, showLabels: showLabels, labelSystem: labelSystem)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: blackKeyWidth)
                            blackKey(startingNote + 1,
                                     label: MusicTheory.noteName(for: startingNote + 1, style: labelSystem),
                                     width: blackKeyWidth,
                                     showLabels: showLabels)
                            Spacer()
                            blackKey(startingNote + 3,
                                     label: MusicTheory.noteName(for: startingNote + 3, style: labelSystem),
                                     width: blackKeyWidth,
                                     showLabels: showLabels)
                            Spacer()
                                .frame(width: blackKeyWidth)
                        }
                        Spacer()
                            .frame(height: geometry.size.height * 0.4)
                    }
                }
            }
            ZStack {
                FBSegment(whiteKeyWidth: whiteKeyWidth, startingNote: startingNote, showLabels: showLabels, labelSystem: labelSystem)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: blackKeyWidth)
                            blackKey(startingNote + 6,
                                     label: MusicTheory.noteName(for: startingNote + 6, style: labelSystem),
                                     width: blackKeyWidth,
                                     showLabels: showLabels)
                            Spacer()
                            blackKey(startingNote + 8,
                                     label: MusicTheory.noteName(for: startingNote + 8, style: labelSystem),
                                     width: blackKeyWidth,
                                     showLabels: showLabels)
                            Spacer()
                            blackKey(startingNote + 10,
                                     label: MusicTheory.noteName(for: startingNote + 10, style: labelSystem),
                                     width: blackKeyWidth,
                                     showLabels: showLabels)
                            Spacer()
                                .frame(width: blackKeyWidth)
                        }
                        Spacer()
                            .frame(height: geometry.size.height * 0.4)
                    }
                }
            }
        }
        .padding(.horizontal, 4)
    }
}

struct PianoView: View {
    let whiteKeyWidth: CGFloat
    let blackKeyWidth: CGFloat
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        VStack(spacing: 10) {
            PianoRegisterView(
                startingNote: 72,  // C5
                whiteKeyWidth: whiteKeyWidth,
                blackKeyWidth: blackKeyWidth,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            PianoRegisterView(
                startingNote: 60,  // C4
                whiteKeyWidth: whiteKeyWidth,
                blackKeyWidth: blackKeyWidth,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            PianoRegisterView(
                startingNote: 48,  // C3
                whiteKeyWidth: whiteKeyWidth,
                blackKeyWidth: blackKeyWidth,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
        }
    }
}

#Preview {
    let screenWidth = UIScreen.main.bounds.width
    let availableWidth = screenWidth - 32
    let whiteKeyWidth = availableWidth / 7
    let blackKeyWidth = whiteKeyWidth * 0.65
    
    return PianoView(
        whiteKeyWidth: whiteKeyWidth,
        blackKeyWidth: blackKeyWidth,
        showLabels: true,
        labelSystem: .none
    )
} 
