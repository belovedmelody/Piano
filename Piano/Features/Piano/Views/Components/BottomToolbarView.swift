import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    @Binding var labelSystem: MusicTheory.LabelSystem
    
    init(showLabels: Binding<Bool>, labelSystem: Binding<MusicTheory.LabelSystem>) {
        self._showLabels = showLabels
        self._labelSystem = labelSystem
    }
    
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
                // Add line spacing action
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.title2)
            }
            
            Spacer()
            
            Menu {
                Button("None") {
                    labelSystem = .none
                    showLabels = false
                }
                Button("♮ Naturals") {
                    labelSystem = .naturals
                    showLabels = true
                }
                Button("♭ Flats") {
                    labelSystem = .flats
                    showLabels = true
                }
                Button("♯ Sharps") {
                    labelSystem = .sharps
                    showLabels = true
                }
            } label: {
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
        labelSystem: .constant(.none)
    )
} 
