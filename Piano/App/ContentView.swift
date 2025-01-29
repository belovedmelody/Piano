import SwiftUI

enum ViewMode {
    case piano
    case scale
}

struct MainContent: View {
    let viewMode: ViewMode
    let pianoLabelsOn: Bool
    let scaleLabelsOn: Bool
    let labelSystem: MusicTheory.LabelSystem
    let selectedTonic: MusicTheory.Tonic
    
    var body: some View {
        if viewMode == .piano {
            PianoView(
                showLabels: pianoLabelsOn,
                labelSystem: labelSystem
            )
            .padding(.vertical, 10)
        } else {
            ScaleView(
                showLabels: scaleLabelsOn,
                labelSystem: labelSystem,
                selectedTonic: selectedTonic
            )
            .padding(.vertical, 10)
            .padding(.horizontal, 4)
        }
    }
}

struct ContentView: View {
    @State private var pianoLabelsOn = false  // Default off for piano
    @State private var scaleLabelsOn = true   // Default on for scale
    @State private var labelSystem: MusicTheory.LabelSystem = .none
    @State private var viewMode: ViewMode = .piano
    @State private var showKeyPicker = false
    @State private var selectedTonic: MusicTheory.Tonic = .c
    
    var body: some View {
        NavigationStack {
            MainContent(
                viewMode: viewMode,
                pianoLabelsOn: pianoLabelsOn,
                scaleLabelsOn: scaleLabelsOn,
                labelSystem: labelSystem,
                selectedTonic: selectedTonic
            )
            .sheet(isPresented: $showKeyPicker) {
                KeySigPicker(selectedTonic: $selectedTonic)
            }
            .safeAreaInset(edge: .bottom) {
                BottomToolbarView(
                    showLabels: viewMode == .piano ? $pianoLabelsOn : $scaleLabelsOn,
                    labelSystem: $labelSystem,
                    viewMode: $viewMode,
                    showKeyPicker: $showKeyPicker
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
