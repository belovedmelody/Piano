// A simplified musical layout containing only key diatonic tones for the selected tonic/keySignature
// ScaleView is activated by the "filter" button in the bottom toolbar, because it filters out the non-diatonic tones.

import SwiftUI

struct ToneBarShape: Shape {
    let cornerRadius: CGFloat = 8
    
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: cornerRadius)
            .path(in: rect)
    }
}

extension View {
    func toneBar(_ midiNote: Int, showLabels: Bool, label: String, isAccidental: Bool, tonic: MusicTheory.Tonic) -> some View {
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
                    ToneBarLabel(
                        text: label,
                        isAccidental: isAccidental,
                        showLabels: showLabels,
                        usesFlats: MusicTheory.usesFlats(tonic)
                    )
                    .padding(.vertical, 16)
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
                    isAccidental: MusicTheory.isAccidental(midiNote),
                    tonic: tonic
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
