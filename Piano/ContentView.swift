import SwiftUI

struct ContentView: View {
    @State private var noteStates = Array(repeating: false, count: 5)
    
    var body: some View {
        NavigationView {
            HStack(spacing: 4) {
                noteButton(60, label: "C4")
                blackNoteButton(61, label: "C#4")
                largeNoteButton(62, label: "D4")
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
}

#Preview {
    ContentView()
} 