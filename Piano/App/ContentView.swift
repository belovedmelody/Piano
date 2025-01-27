import SwiftUI

struct ContentView: View {
    @State private var showLabels = false  // Start with labels hidden
    @State private var labelSystem: MusicTheory.LabelSystem = .none
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32
        let whiteKeyWidth = availableWidth / 7
        let blackKeyWidth = whiteKeyWidth * 0.65
        
        NavigationStack {
            VStack {
                PianoView(
                    whiteKeyWidth: whiteKeyWidth,
                    blackKeyWidth: blackKeyWidth,
                    showLabels: showLabels,
                    labelSystem: labelSystem
                )
                .padding(.vertical, 10)
                
                Spacer()
                
                BottomToolbarView(
                    showLabels: $showLabels,
                    labelSystem: $labelSystem
                )
            }
            .navigationTitle("Piano")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemGray6), for: .navigationBar)
            .background(Color(.systemGray4))
        }
        .tint(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
