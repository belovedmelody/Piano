// Vertical stack of three C-based piano octaves for default ContentView

import SwiftUI

struct OctaveStack: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        VStack(spacing: 10) {
            // Top octave (C5)
            ExtendedOctaveView(
                tonic: 72,  // C5
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            // Middle octave (C4)
            ExtendedOctaveView(
                tonic: 60,  // C4
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            // Bottom octave (C3)
            ExtendedOctaveView(
                tonic: 48,  // C3
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
            labelSystem: labelSystem
        )
    }
}

#Preview {
    PianoView(
        showLabels: true,
        labelSystem: .none
    )
} 
