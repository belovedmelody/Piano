import SwiftUI

struct ExtendedRegisterView: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            KeySegment(
                whiteNotes: PianoView.lowerFBSegment().whiteKeys,
                blackNotes: PianoView.lowerFBSegment().blackKeys,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            KeySegment(
                whiteNotes: PianoView.lowerCESegment().whiteKeys,
                blackNotes: PianoView.lowerCESegment().blackKeys,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            KeySegment(
                whiteNotes: PianoView.upperFBSegment().whiteKeys,
                blackNotes: PianoView.upperFBSegment().blackKeys,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            KeySegment(
                whiteNotes: PianoView.upperCESegment().whiteKeys,
                blackNotes: PianoView.upperCESegment().blackKeys,
                showLabels: showLabels,
                labelSystem: labelSystem
            )
        }
    }
}

#Preview {
    ExtendedRegisterView(
        showLabels: true,
        labelSystem: .naturals
    )
    .padding()
} 
