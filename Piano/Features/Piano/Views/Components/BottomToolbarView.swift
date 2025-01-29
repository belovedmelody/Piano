import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    @Binding var labelSystem: MusicTheory.LabelSystem
    @Binding var viewMode: ViewMode
    @Binding var selectedTonic: MusicTheory.Tonic
    
    var body: some View {
        HStack {
            Button(action: {
                if let currentIndex = MusicTheory.Tonic.allCases.firstIndex(of: selectedTonic),
                   currentIndex > 0 {
                    selectedTonic = MusicTheory.Tonic.allCases[currentIndex - 1]
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Spacer()
            
            Button(action: {
                if let currentIndex = MusicTheory.Tonic.allCases.firstIndex(of: selectedTonic),
                   currentIndex < MusicTheory.Tonic.allCases.count - 1 {
                    selectedTonic = MusicTheory.Tonic.allCases[currentIndex + 1]
                }
            }) {
                Image(systemName: "chevron.right")
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
        selectedTonic: .constant(.c)
    )
} 
