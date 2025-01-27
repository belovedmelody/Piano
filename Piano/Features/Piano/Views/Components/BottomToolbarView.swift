import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    @Binding var labelStyle: MusicTheory.LabelStyle
    
    init(showLabels: Binding<Bool>, labelStyle: Binding<MusicTheory.LabelStyle>) {
        self._showLabels = showLabels
        self._labelStyle = labelStyle
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
                    labelStyle = .none
                    showLabels = false
                }
                Button("♭ Flats") {
                    labelStyle = .flats
                    showLabels = true
                }
                Button("♯ Sharps") {
                    labelStyle = .sharps
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
        labelStyle: .constant(.none)
    )
} 
