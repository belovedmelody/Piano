import SwiftUI

struct ToneBarShape: Shape {
    let cornerRadius: CGFloat = 8
    
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: cornerRadius)
            .path(in: rect)
    }
}

extension View {
    func toneBar(_ midiNote: Int, showLabels: Bool, label: String, isAccidental: Bool) -> some View {
        NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: .constant(false)
            ),
            style: NoteButtonStyle(
                inactiveColor: isAccidental ? Color(UIColor.gray) : .white,
                overlayColor: isAccidental ? .white : .black,
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
                            .foregroundColor(isAccidental ? 
                                Color(UIColor.systemGray5.resolvedColor(with: .init(userInterfaceStyle: .light))) :
                                Color(.systemGray2))
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
    let tonic: MusicTheory.Tonic
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(midiNotes, id: \.self) { midiNote in
                toneBar(
                    midiNote,
                    showLabels: showLabels,
                    label: MusicTheory.noteName(for: midiNote, tonic: tonic),
                    isAccidental: MusicTheory.isAccidental(midiNote)
                )
            }
        }
    }
}

struct ScaleView: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    let selectedTonic: MusicTheory.Tonic
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(MusicTheory.scaleRegisters(tonic: selectedTonic), id: \.self) { register in
                ScaleViewRegister(
                    midiNotes: register,
                    showLabels: showLabels,
                    tonic: selectedTonic
                )
            }
        }
    }
}

#Preview {
    ScaleView(
        showLabels: true,
        labelSystem: .sharps,
        selectedTonic: .c
    )
    .padding()
} 
