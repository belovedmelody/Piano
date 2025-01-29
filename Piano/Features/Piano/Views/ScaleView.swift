import SwiftUI

struct ToneBarShape: Shape {
    let cornerRadius: CGFloat = 8
    
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: cornerRadius)
            .path(in: rect)
    }
}

extension View {
    func toneBar(_ midiNote: Int, showLabels: Bool, label: String) -> some View {
        NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: .constant(false)
            ),
            style: NoteButtonStyle(
                inactiveColor: .white,
                overlayColor: .black,
                overlayOpacity: 0.2,
                hapticStyle: .rigid,
                hapticIntensity: 0.67,
                shape: { rect in
                    ToneBarShape().path(in: rect)
                },
                shadowEnabled: true,
                label: {
                    if showLabels {
                        Text(label)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundColor(Color(.systemGray2))
                    }
                }
            )
        )
        .frame(maxWidth: .infinity)
    }
}

struct ScaleViewRegister: View {
    let midiNotes: [Int]
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(midiNotes, id: \.self) { midiNote in
                toneBar(
                    midiNote,
                    showLabels: showLabels,
                    label: MusicTheory.noteName(for: midiNote, style: labelSystem)
                )
            }
        }
    }
}

struct ScaleView: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        VStack(spacing: 10) {
            ScaleViewRegister(
                midiNotes: [72, 74, 76, 77, 79, 81, 83],  // C5 to B5
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            ScaleViewRegister(
                midiNotes: [60, 62, 64, 65, 67, 69, 71],  // C4 to B4
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            ScaleViewRegister(
                midiNotes: [48, 50, 52, 53, 55, 57, 59],  // C3 to B3
                showLabels: showLabels,
                labelSystem: labelSystem
            )
        }
    }
}

#Preview {
    ScaleView(
        showLabels: true,
        labelSystem: .sharps
    )
    .padding()
} 