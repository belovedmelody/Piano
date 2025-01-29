import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    @Binding var labelSystem: MusicTheory.LabelSystem
    @Binding var viewMode: ViewMode
    @Binding var showKeyPicker: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                showKeyPicker.toggle()
            }) {
                Image(systemName: "tuningfork")
                    .font(.title2)
            }
            
            Spacer()
            
            Button(action: {
                if viewMode == .piano {
                    viewMode = .scale
                    labelSystem = .naturals
                } else {
                    viewMode = .piano
                    labelSystem = .naturals
                }
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .symbolVariant(viewMode == .piano ? .none : .fill)
                    .font(.title2)
            }
            
            Spacer()
            
            Button(action: {
                showLabels.toggle()
                if showLabels {
                    labelSystem = .naturals
                }
            }) {
                Image(systemName: "textformat")
                    .font(.title2)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

#Preview {
    BottomToolbarView(
        showLabels: .constant(true),
        labelSystem: .constant(.none),
        viewMode: .constant(.piano),
        showKeyPicker: .constant(false)
    )
} 
