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
        ZStack {
            // Base layer with tuning fork and labels buttons
            HStack {
                Button {
                    showKeyPicker.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "tuningfork")
                            .font(.title2)
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
                        .font(.title2)
                }
            }
            
            // Filter button layer
            Button {
                viewMode = viewMode == .piano ? .scale : .piano
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .symbolVariant(viewMode == .piano ? .none : .fill)
                    .font(.title2)
            }
        }
        .padding()
        .background(.thickMaterial)
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
