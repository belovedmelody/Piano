// The bottom strip for musical view controls
// Tuning fork activates the key signature picker
// Filter switches between piano (unfiltered) and scale (diatonically filtered) views
// Text format toggles the label system

import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    @Binding var labelSystem: MusicTheory.LabelSystem
    @Binding var viewMode: ViewMode
    @Binding var selectedTonic: MusicTheory.Tonic
    @Binding var showKeyPicker: Bool
    
    var body: some View {
        HStack {
            Button {
                showKeyPicker.toggle()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "tuningfork")
                    Text(selectedTonic.rawDisplayName)
                        .font(.title3)
                        .fontDesign(.rounded)
                }
            }
            
            Spacer()
            
            Button {
                showLabels.toggle()
                if showLabels {
                    labelSystem = .naturals
                }
            } label: {
                Image(systemName: "textformat")
            }
        }
    }
}

#Preview {
    BottomToolbarView(
        showLabels: .constant(true),
        labelSystem: .constant(.none),
        viewMode: .constant(.piano),
        selectedTonic: .constant(.c),
        showKeyPicker: .constant(false)
    )
} 
