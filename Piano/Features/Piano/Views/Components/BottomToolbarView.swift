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
                Image(systemName: "tuningfork")
                    .font(.title2)
            }
            
            Spacer()
            
            Button {
                viewMode = viewMode == .piano ? .scale : .piano
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .symbolVariant(viewMode == .piano ? .none : .fill)
                    .font(.title2)
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
