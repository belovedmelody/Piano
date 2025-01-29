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

struct CESegment: View {
    let baseC: Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        ZStack {
            // White keys layer
            HStack(spacing: 4) {
                whiteKey(baseC + 0,
                        label: MusicTheory.noteName(for: baseC + 0, style: labelSystem),
                        showLabels: showLabels)
                whiteKey(baseC + 2,
                        label: MusicTheory.noteName(for: baseC + 2, style: labelSystem),
                        showLabels: showLabels)
                whiteKey(baseC + 4,
                        label: MusicTheory.noteName(for: baseC + 4, style: labelSystem),
                        showLabels: showLabels)
            }
            
            // Black keys layer
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: whiteKeyWidth * 0.65)
                        blackKey(baseC + 1,
                                label: MusicTheory.noteName(for: baseC + 1, style: labelSystem),
                                showLabels: showLabels)
                        Spacer()
                        blackKey(baseC + 3,
                                label: MusicTheory.noteName(for: baseC + 3, style: labelSystem),
                                showLabels: showLabels)
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

struct FBSegment: View {
    let baseC: Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        ZStack {
            // White keys layer
            HStack(spacing: 4) {
                whiteKey(baseC + 5,
                        label: MusicTheory.noteName(for: baseC + 5, style: labelSystem),
                        showLabels: showLabels)
                whiteKey(baseC + 7,
                        label: MusicTheory.noteName(for: baseC + 7, style: labelSystem),
                        showLabels: showLabels)
                whiteKey(baseC + 9,
                        label: MusicTheory.noteName(for: baseC + 9, style: labelSystem),
                        showLabels: showLabels)
                whiteKey(baseC + 11,
                        label: MusicTheory.noteName(for: baseC + 11, style: labelSystem),
                        showLabels: showLabels)
            }
            
            // Black keys layer
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                            .frame(width: whiteKeyWidth * 0.65)
                        blackKey(baseC + 6,
                                label: MusicTheory.noteName(for: baseC + 6, style: labelSystem),
                                showLabels: showLabels)
                        Spacer()
                        blackKey(baseC + 8,
                                label: MusicTheory.noteName(for: baseC + 8, style: labelSystem),
                                showLabels: showLabels)
                        Spacer()
                        blackKey(baseC + 10,
                                label: MusicTheory.noteName(for: baseC + 10, style: labelSystem),
                                showLabels: showLabels)
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

struct PianoRegisterView: View {
    let baseC: Int
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            CESegment(
                baseC: baseC,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            FBSegment(
                baseC: baseC,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
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
}

#Preview {
    return PianoView(
        showLabels: true,
        labelSystem: .none
    )
} 
