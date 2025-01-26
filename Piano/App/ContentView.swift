import SwiftUI

struct ContentView: View {
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32
        let whiteKeyWidth = availableWidth / 7
        let blackKeyWidth = whiteKeyWidth * 0.65
        
        NavigationStack {
            VStack {
                PianoView(
                    whiteKeyWidth: whiteKeyWidth,
                    blackKeyWidth: blackKeyWidth
                )
                .padding(.vertical, 10)
                
                Spacer()
                
                BottomToolbarView()
            }
            .navigationTitle("Piano")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemGray6), for: .navigationBar)
            .background(Color(.systemGray4))
        }
    }
}

#Preview {
    ContentView()
} 
