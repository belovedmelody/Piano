import SwiftUI

struct ContentView: View {
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32 // Total padding: 4 + 4 + 28 (navigation)
        let whiteKeyWidth = availableWidth / 7  // Divide by number of white keys
        let blackKeyWidth = whiteKeyWidth * 0.65
        
        NavigationView {
            VStack {
                Text("White key width: \(whiteKeyWidth)")
                Text("Black key width: \(blackKeyWidth)")
                
                PianoView(whiteKeyWidth: whiteKeyWidth, blackKeyWidth: blackKeyWidth)
                    .frame(maxHeight: 200)
                    .background(Color(.systemGray4))
            }
        }
    }
}

#Preview {
    ContentView()
} 
