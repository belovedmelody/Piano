import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    @Binding var labelSystem: MusicTheory.LabelSystem
    @Binding var viewMode: ViewMode
    
    var body: some View {
        HStack {
            Button(action: {
                // Add tuning action
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
                // Removed all showLabels manipulation since it's handled by ContentView
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
        viewMode: .constant(.piano)
    )
} 
