// Extension of the NoteButtonView, defining the shape, dimensions, and behaviors of piano keys.

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
