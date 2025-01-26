import SwiftUI

extension View {
    func whiteKey(_ midiNote: Int, label: String, width: CGFloat) -> some View {
        NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: .constant(false)
            ),
            style: NoteButtonStyle(
                inactiveColor: .white,
                overlayColor: .black,
                overlayOpacity: 0.12,
                hapticStyle: .rigid,
                hapticIntensity: 0.67,
                shape: { rect in
                    Path { path in
                        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 8))
                        path.addArc(
                            center: CGPoint(x: rect.maxX - 8, y: rect.maxY - 8),
                            radius: 8,
                            startAngle: .degrees(0),
                            endAngle: .degrees(90),
                            clockwise: false
                        )
                        path.addLine(to: CGPoint(x: rect.minX + 8, y: rect.maxY))
                        path.addArc(
                            center: CGPoint(x: rect.minX + 8, y: rect.maxY - 8),
                            radius: 8,
                            startAngle: .degrees(90),
                            endAngle: .degrees(180),
                            clockwise: false
                        )
                        path.closeSubpath()
                    }
                },
                shadowEnabled: true,
                label: {
                    VStack {
                        Spacer()
                        Text(label)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 16)
                    }
                }
            )
        )
        .frame(width: width)
    }

    func blackKey(_ midiNote: Int, label: String, width: CGFloat) -> some View {
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
                    Path { path in
                        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 8))
                        path.addArc(
                            center: CGPoint(x: rect.maxX - 8, y: rect.maxY - 8),
                            radius: 8,
                            startAngle: .degrees(0),
                            endAngle: .degrees(90),
                            clockwise: false
                        )
                        path.addLine(to: CGPoint(x: rect.minX + 8, y: rect.maxY))
                        path.addArc(
                            center: CGPoint(x: rect.minX + 8, y: rect.maxY - 8),
                            radius: 8,
                            startAngle: .degrees(90),
                            endAngle: .degrees(180),
                            clockwise: false
                        )
                        path.closeSubpath()
                    }
                },
                shadowEnabled: true,
                label: {
                    VStack {
                        Spacer()
                        Text(label)
                            .font(.caption)
                            .foregroundColor(Color(.systemGray2))
                            .padding(.bottom, 16)
                    }
                }
            )
        )
        .frame(width: width)
    }
}

struct CESegment: View {
    let whiteKeyWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(60, label: "C", width: whiteKeyWidth)
            whiteKey(62, label: "D", width: whiteKeyWidth)
            whiteKey(64, label: "E", width: whiteKeyWidth)
        }
    }
}

struct FBSegment: View {
    let whiteKeyWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(65, label: "F", width: whiteKeyWidth)
            whiteKey(67, label: "G", width: whiteKeyWidth)
            whiteKey(69, label: "A", width: whiteKeyWidth)
            whiteKey(71, label: "B", width: whiteKeyWidth)
        }
    }
}

struct PianoRegisterView: View {
    let whiteKeyWidth: CGFloat
    let blackKeyWidth: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                CESegment(whiteKeyWidth: whiteKeyWidth)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: blackKeyWidth)
                            blackKey(61, label: "C#", width: blackKeyWidth)
                            Spacer()
                            blackKey(63, label: "D#", width: blackKeyWidth)
                            Spacer()
                                .frame(width: blackKeyWidth)
                        }
                        Spacer()
                            .frame(height: geometry.size.height * 0.4)
                    }
                }
            }
            ZStack {
                FBSegment(whiteKeyWidth: whiteKeyWidth)
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                                .frame(width: blackKeyWidth)
                            blackKey(66, label: "F#", width: blackKeyWidth)
                            Spacer()
                            blackKey(68, label: "G#", width: blackKeyWidth)
                            Spacer()
                            blackKey(70, label: "A#", width: blackKeyWidth)
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
    
    var body: some View {
        PianoRegisterView(whiteKeyWidth: whiteKeyWidth, blackKeyWidth: blackKeyWidth)
    }
}

#Preview {
    PianoView(whiteKeyWidth: 50, blackKeyWidth: 50)
} 
