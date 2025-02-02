// A pitch pipe for selecting the tonic 
import SwiftUI

struct KeySigPicker: View {
    @Binding var selectedTonic: MusicTheory.Tonic
    @Binding var isVisible: Bool
    
    var body: some View {
        if isVisible {
            ZStack {
                // Background with border
                RoundedRectangle(cornerRadius: 999)
                    .fill(.thickMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .strokeBorder(.quaternary)
                    )
                    .frame(width: 250, height: 60)
                
                // Foreground
                VStack {
                    Picker("Key", selection: $selectedTonic) {
                        ForEach(MusicTheory.Tonic.allCases.reversed(), id: \.self) { tonic in
                            Text(tonic.rawDisplayName)
                                .font(.title3)
                                .foregroundColor(.primary)
                                .fontDesign(.rounded)
                                .rotationEffect(.degrees(-90))
                        }
                    }
                    .pickerStyle(.wheel)
                    .rotationEffect(.degrees(90))
                }
                .frame(width: 48)
            }
        }
    }
}

#Preview {
    KeySigPicker(
        selectedTonic: .constant(.c),
        isVisible: .constant(true)
    )
    .padding(.bottom, 32)
} 