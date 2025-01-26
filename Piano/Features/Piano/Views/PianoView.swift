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
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 16)
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
                                    .foregroundColor(Color(.systemGray2))
                                    .padding(.bottom, 16)
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
    
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(startingNote + 0, label: "C", width: whiteKeyWidth, showLabels: showLabels)
            whiteKey(startingNote + 2, label: "D", width: whiteKeyWidth, showLabels: showLabels)
            whiteKey(startingNote + 4, label: "E", width: whiteKeyWidth, showLabels: showLabels)
        }
    }
}

struct FBSegment: View {
    let whiteKeyWidth: CGFloat
    let startingNote: Int
    let showLabels: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(startingNote + 5, label: "F", width: whiteKeyWidth, showLabels: showLabels)
            whiteKey(startingNote + 7, label: "G", width: whiteKeyWidth, showLabels: showLabels)
            whiteKey(startingNote + 9, label: "A", width: whiteKeyWidth, showLabels: showLabels)
            whiteKey(startingNote + 11, label: "B", width: whiteKeyWidth, showLabels: showLabels)
        }
    }
}

struct PianoRegisterView: View {
    let startingNote: Int
    let whiteKeyWidth: CGFloat
    let blackKeyWidth: CGFloat
    let showLabels: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                CESegment(whiteKeyWidth: whiteKeyWidth, startingNote: startingNote, showLabels: showLabels)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: blackKeyWidth)
                            blackKey(startingNote + 1, label: "C#", width: blackKeyWidth, showLabels: showLabels)
                            Spacer()
                            blackKey(startingNote + 3, label: "D#", width: blackKeyWidth, showLabels: showLabels)
                            Spacer()
                                .frame(width: blackKeyWidth)
                        }
                        Spacer()
                            .frame(height: geometry.size.height * 0.4)
                    }
                }
            }
            ZStack {
                FBSegment(whiteKeyWidth: whiteKeyWidth, startingNote: startingNote, showLabels: showLabels)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: blackKeyWidth)
                            blackKey(startingNote + 6, label: "F#", width: blackKeyWidth, showLabels: showLabels)
                            Spacer()
                            blackKey(startingNote + 8, label: "G#", width: blackKeyWidth, showLabels: showLabels)
                            Spacer()
                            blackKey(startingNote + 10, label: "A#", width: blackKeyWidth, showLabels: showLabels)
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
    
    var body: some View {
        VStack(spacing: 10) {
            PianoRegisterView(
                startingNote: 72,  // C5
                whiteKeyWidth: whiteKeyWidth,
                blackKeyWidth: blackKeyWidth,
                showLabels: showLabels
            )
            
            PianoRegisterView(
                startingNote: 60,  // C4
                whiteKeyWidth: whiteKeyWidth,
                blackKeyWidth: blackKeyWidth,
                showLabels: showLabels
            )
            
            PianoRegisterView(
                startingNote: 48,  // C3
                whiteKeyWidth: whiteKeyWidth,
                blackKeyWidth: blackKeyWidth,
                showLabels: showLabels
            )
        }
    }
}

#Preview {
    PianoView(
        whiteKeyWidth: 50,
        blackKeyWidth: 32.5,
        showLabels: true
    )
} 
