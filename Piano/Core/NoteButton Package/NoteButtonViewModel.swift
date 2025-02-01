import SwiftUI

class NoteButtonViewModel: ObservableObject {
    let noteNumbers: [Int]
    private let pressedBinding: Binding<Bool>
    
    @Published private(set) var isPressed: Bool
    
    init(noteNumbers: [Int], 
         isPressed: Binding<Bool>
    ) {
        self.noteNumbers = noteNumbers
        self.pressedBinding = isPressed
        self.isPressed = isPressed.wrappedValue
    }
    
    func handlePress(isActive: Bool) {
        isPressed = isActive
        if isActive {
            noteNumbers.forEach { note in
                AudioEngine.shared.noteOn(noteNumber: note)
            }
        } else {
            noteNumbers.forEach { AudioEngine.shared.noteOff(noteNumber: $0) }
        }
    }
    
    func updateIsPressed(_ newValue: Bool) {
        isPressed = newValue
        pressedBinding.wrappedValue = newValue
    }
} 

//Notes
