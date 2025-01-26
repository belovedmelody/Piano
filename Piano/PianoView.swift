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

struct PianoView: View {
    var body: some View {
        HStack(spacing: 4) {
            CESegment()
            FBSegment()
        }
        .frame(width: 300, height: 200)
        .padding()
        .background(Color(.systemGray4))
    }
}

#Preview {
    PianoView()
} 