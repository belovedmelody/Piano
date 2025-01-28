import SwiftUI

enum ViewMode {
    case piano
    case scale
}

struct ContentView: View {
    @State private var showLabels = false  // Start with labels hidden
    @State private var labelSystem: MusicTheory.LabelSystem = .none
    @State private var viewMode: ViewMode = .piano
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - 32
        let whiteKeyWidth = availableWidth / 7
        let blackKeyWidth = whiteKeyWidth * 0.65
        
        NavigationStack {
            VStack {
                if viewMode == .piano {
                    PianoView(
                        whiteKeyWidth: whiteKeyWidth,
                        blackKeyWidth: blackKeyWidth,
                        showLabels: showLabels,
                        labelSystem: labelSystem
                    )
                    .padding(.vertical, 10)
                } else {
                    ScaleView(labelSystem: labelSystem)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 4)
                }
                
                Spacer()
                
                BottomToolbarView(
                    showLabels: $showLabels,
                    labelSystem: $labelSystem,
                    viewMode: $viewMode
                )
            }
            .navigationTitle("Piano")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemGray6), for: .navigationBar)
            .background(viewMode == .piano ? Color(.systemGray4) : Color(.systemGray6))
        }
        .tint(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
