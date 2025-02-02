// Vertical stack of three C-based piano octaves for default ContentView

import SwiftUI

struct OctaveStack: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    let baseTonic: Int
    
    var body: some View {
        VStack(spacing: 10) {
            ExtendedOctaveView(
                tonic: baseTonic + 12,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            ExtendedOctaveView(
                tonic: baseTonic,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            ExtendedOctaveView(
                tonic: baseTonic - 12,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
        }
    }
}

struct PianoView: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        OctaveStack(
            showLabels: showLabels,
            labelSystem: labelSystem,
            baseTonic: 60
        )
    }
}

#Preview {
    PianoView(
        showLabels: true,
        labelSystem: .none
    )
} 
