import SwiftUI

struct KeySigPicker: View {
    @Binding var selectedTonic: MusicTheory.Tonic
    
    var body: some View {
        Picker("Key", selection: $selectedTonic) {
            ForEach(Array(MusicTheory.Tonic.allCases.reversed()), id: \.self) { tonic in
                Text(tonic.rawDisplayName)
                    .tag(tonic)
            }
        }
        .pickerStyle(.wheel)
        .presentationDetents([.fraction(0.3)])
        .presentationBackground(.thickMaterial)
    }
}

#Preview {
    KeySigPicker(selectedTonic: .constant(.f_lower))
} 