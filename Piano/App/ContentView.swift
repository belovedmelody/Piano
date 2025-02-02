// ContentView is where we load into the three-octave view by default. 
// It should remain the singular view, except for Settings/Preferences. 
// ContentView should remain simple, with as much logic offloaded to as possible.

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
    let showKeyPicker: Bool
    let baseTonic: Int
    
    var body: some View {
        if viewMode == .piano {
            OctaveStack(
                showLabels: pianoLabelsOn,
                labelSystem: labelSystem,
                baseTonic: baseTonic
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
    @State private var pianoLabelsOn = false
    @State private var scaleLabelsOn = true
    @State private var labelSystem: MusicTheory.LabelSystem = .none
    @State private var viewMode: ViewMode = .piano
    @State private var selectedTonic: MusicTheory.Tonic = .c
    @State private var showKeyPicker = false
    @State private var baseTonic: Int = 60  // Add this for middle C
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainContent(
                    viewMode: viewMode,
                    pianoLabelsOn: pianoLabelsOn,
                    scaleLabelsOn: scaleLabelsOn,
                    labelSystem: labelSystem,
                    selectedTonic: selectedTonic,
                    showKeyPicker: showKeyPicker,
                    baseTonic: baseTonic
                )
                .toolbar {
                    // Top bar filter button
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewMode = viewMode == .piano ? .scale : .piano
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .symbolVariant(viewMode == .piano ? .none : .fill)
                        }
                    }
                    
                    // Bottom bar controls
                    ToolbarItem(placement: .bottomBar) {
                        BottomToolbarView(
                            showLabels: viewMode == .piano ? $pianoLabelsOn : $scaleLabelsOn,
                            labelSystem: $labelSystem,
                            viewMode: $viewMode,
                            selectedTonic: $selectedTonic,
                            showKeyPicker: $showKeyPicker
                        )
                    }
                }
                .navigationTitle("Piano")
                .navigationBarTitleDisplayMode(.large)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color(.systemGray6), for: .navigationBar)
                .toolbarBackground(.visible, for: .bottomBar)
                .toolbarBackground(Color(.systemGray6), for: .bottomBar)
                .background(Color(.systemGray4))
                
                VStack {
                    Spacer()
                    KeySigPicker(
                        selectedTonic: $selectedTonic,
                        isVisible: $showKeyPicker
                    )
                    .padding(.bottom, 32)
                }
            }
        }
        .tint(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 

// Notes
