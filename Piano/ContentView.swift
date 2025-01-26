import SwiftUI

struct ContentView: View {
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32 // Total padding: 4 + 4 + 28 (navigation)
        let whiteKeyWidth = availableWidth / 7  // Divide by number of white keys
        
        NavigationView {
            VStack {
                // Print the calculated width to verify
                Text("White key width: \(whiteKeyWidth)")
                
                PianoView(whiteKeyWidth: whiteKeyWidth)
                    .frame(maxHeight: 200)
                    .background(Color(.systemGray4))
                
                // CE test layout
                ZStack {
                    HStack(spacing: 4) {
                        CESegment(whiteKeyWidth: whiteKeyWidth)
                    }
                    .padding(.horizontal, 4)
                    
                    HStack(spacing: 0) {
                        blackKey(61, label: "C#")
                        blackKey(63, label: "D#")
                    }
                }
                .frame(height: 200)
                .background(Color(.systemGray4))
                
                // FB test layout
                ZStack {
                    HStack(spacing: 4) {
                        FBSegment(whiteKeyWidth: whiteKeyWidth)
                    }
                    .padding(.horizontal, 4)
                    
                    HStack(spacing: 0) {
                        blackKey(66, label: "F#")
                        blackKey(68, label: "G#")
                        blackKey(70, label: "A#")
                    }
                }
                .frame(height: 200)
                .background(Color(.systemGray4))
            }
        }
    }
}

#Preview {
    ContentView()
} 
