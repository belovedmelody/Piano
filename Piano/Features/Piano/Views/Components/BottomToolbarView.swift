import SwiftUI

struct BottomToolbarView: View {
    @Binding var showLabels: Bool
    
    init(showLabels: Binding<Bool>) {
        self._showLabels = showLabels
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
            
            Button(action: {
                showLabels.toggle()
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
    BottomToolbarView(showLabels: .constant(true))
} 
