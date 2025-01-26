import SwiftUI

struct BottomToolbarView: View {
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
                // Add text format action
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
    BottomToolbarView()
} 
