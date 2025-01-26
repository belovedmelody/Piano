import SwiftUI

extension View {
    fileprivate func whiteKey(_ midiNote: Int, label: String) -> some View {
        NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: .constant(false)
            ),
            style: NoteButtonStyle(
                inactiveColor: .white,          // White background
                overlayColor: .black,           // Black overlay
                overlayOpacity: 0.12,           // Subtle opacity when pressed
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
    }
}

struct CESegment: View {
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(60, label: "C")  // C
            whiteKey(62, label: "D")  // D
            whiteKey(64, label: "E")  // E
        }
    }
}

struct FBSegment: View {
    var body: some View {
        HStack(spacing: 4) {
            whiteKey(65, label: "F")  // F
            whiteKey(67, label: "G")  // G
            whiteKey(69, label: "A")  // A
            whiteKey(71, label: "B")  // B
        }
    }
}

struct PianoRegisterView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 4) {
                CESegment()
                    .frame(width: geometry.size.width * (3/7))  // 3 of 7 white keys
                FBSegment()
                    .frame(width: geometry.size.width * (4/7))  // 4 of 7 white keys
            }
        }
    }
}

struct PianoView: View {
    var body: some View {
        PianoRegisterView()
    }
}

#Preview {
    PianoView()
} 