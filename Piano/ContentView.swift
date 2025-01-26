import SwiftUI

struct ContentView: View {
    @State private var noteStates = Array(repeating: false, count: 5)
    
    var body: some View {
        NavigationView {
            HStack(spacing: 4) {
                // No shadow (default)
                whiteKey(62)  // Try our new white key
                
                // Black key with default shadow
                NoteButtonView(
                    viewModel: NoteButtonViewModel(
                        noteNumbers: [61],
                        isPressed: .constant(false)
                    ),
                    style: NoteButtonStyle(
                        inactiveColor: .black,
                        overlayColor: .white,
                        overlayOpacity: 0.15,
                        shadowEnabled: true,
                        label: { Text("C#4") }
                    )
                )
                
                // Large key with custom deeper shadow
                NoteButtonView(
                    viewModel: NoteButtonViewModel(
                        noteNumbers: [62],
                        isPressed: .constant(false)
                    ),
                    style: NoteButtonStyle(
                        shadowEnabled: true,
                        shadowY: 4,
                        shadowRadius: 3,
                        label: { Text("D4") }
                    )
                )
                .frame(height: 120)
                
                // Default shadow
                noteButton(64, label: "E4")
                
                noteButton(65, label: "F4")
            }
            .frame(width: 300, height: 200)
            .padding()
            .background(Color(.systemGray4))
        }
    }
}

// Button variants defined here instead
extension View {
    fileprivate func blackNoteButton(_ midiNote: Int, label: String? = nil) -> some View {
        @State var isPressed = false
        return NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: $isPressed
            ),
            style: NoteButtonStyle(
                inactiveColor: .black,
                overlayColor: .white,
                overlayOpacity: 0.15,
                label: { label.map { Text($0) } }
            )
        )
    }
    
    fileprivate func largeNoteButton(_ midiNote: Int, label: String? = nil) -> some View {
        noteButton(midiNote, label: label)
            .frame(height: 120)
    }
    
    fileprivate func whiteKey(_ midiNote: Int) -> some View {
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
                        Text("D")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 16)
                    }
                }
            )
        )
    }
}

#Preview {
    ContentView()
} 