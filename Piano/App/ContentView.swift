import SwiftUI

enum ViewMode {
    case piano
    case scale
}

struct ContentView: View {
    @State private var pianoLabelsOn = false  // Default off for piano
    @State private var scaleLabelsOn = true   // Default on for scale
    @State private var labelSystem: MusicTheory.LabelSystem = .none
    @State private var viewMode: ViewMode = .piano
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewMode == .piano {
                    PianoView(
                        showLabels: pianoLabelsOn,
                        labelSystem: labelSystem
                    )
                    .padding(.vertical, 10)
                } else {
                    ScaleView(
                        showLabels: scaleLabelsOn,
                        labelSystem: labelSystem
                    )
                    .padding(.vertical, 10)
                    .padding(.horizontal, 4)
                }
                
                Spacer()
                
                BottomToolbarView(
                    showLabels: viewMode == .piano ? $pianoLabelsOn : $scaleLabelsOn,
                    labelSystem: $labelSystem,
                    viewMode: $viewMode
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
