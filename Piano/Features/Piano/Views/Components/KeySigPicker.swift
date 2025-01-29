import SwiftUI

struct KeySigPicker: View {
    @Binding var selectedTonic: MusicTheory.Tonic
    
    var body: some View {
        HStack(spacing: 40) {
            Button(action: {
                if let currentIndex = MusicTheory.Tonic.allCases.firstIndex(of: selectedTonic),
                   currentIndex > 0 {
                    selectedTonic = MusicTheory.Tonic.allCases[currentIndex - 1]
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Text(selectedTonic.rawDisplayName)
                .font(.title2)
            
            Button(action: {
                if let currentIndex = MusicTheory.Tonic.allCases.firstIndex(of: selectedTonic),
                   currentIndex < MusicTheory.Tonic.allCases.count - 1 {
                    selectedTonic = MusicTheory.Tonic.allCases[currentIndex + 1]
                }
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
        .padding()
        .presentationDetents([.height(80)])  // Reduced height since we don't need wheel space
        .presentationBackground(.thickMaterial)
    }
}

#Preview {
    KeySigPicker(selectedTonic: .constant(.f_lower))
} 