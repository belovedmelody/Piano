// The Swiftiest of the noteButton package. 
// Specifies all the parameters accessible, as well as their default values.

import SwiftUI
import UIKit  // For UIImpactFeedbackGenerator


struct NoteButtonStyle<Label: View> {
    let inactiveColor: Color
    let overlayColor: Color
    let overlayOpacity: Double
    let hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle
    let hapticIntensity: Double
    let shape: (CGRect) -> Path
    let label: Label?
    let shadowEnabled: Bool
    let shadowY: CGFloat
    let shadowRadius: CGFloat
    
    init(
        inactiveColor: Color = .accentColor,
        overlayColor: Color = .white,
        overlayOpacity: Double = 0.2,
        hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle = .rigid,
        hapticIntensity: Double = 0.67,
        shape: @escaping (CGRect) -> Path = { RoundedRectangle(cornerRadius: 10).path(in: $0) },
        shadowEnabled: Bool = false,
        shadowY: CGFloat = 2,
        shadowRadius: CGFloat = 2,
        @ViewBuilder label: () -> Label?
    ) {
        self.inactiveColor = inactiveColor
        self.overlayColor = overlayColor
        self.overlayOpacity = overlayOpacity
        self.hapticStyle = hapticStyle
        self.hapticIntensity = hapticIntensity
        self.shape = shape
        self.shadowEnabled = shadowEnabled
        self.shadowY = shadowY
        self.shadowRadius = shadowRadius
        self.label = label()
    }
}


struct NoteButtonView<Label: View>: View {
    @StateObject var viewModel: NoteButtonViewModel
    let style: NoteButtonStyle<Label>
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    style.shape(geometry.frame(in: .local))
                        .fill(style.inactiveColor)
                        .shadow(
                            color: .black.opacity(style.shadowEnabled ? 0.25 : 0),
                            radius: style.shadowRadius,
                            x: 0,
                            y: style.shadowY
                        )
                    
                    if let label = style.label {
                        label
                            .font(.body)
                            .foregroundColor(.primary)
                            .animation(nil, value: viewModel.isPressed)
                    }
                    
                    style.shape(geometry.frame(in: .local))
                        .fill(style.overlayColor.opacity(viewModel.isPressed ? style.overlayOpacity : 0))
                }
                .animation(nil, value: viewModel.isPressed)
            }
            
            TouchHandlingView(viewModel: viewModel, shape: style.shape)
        }
        .animation(nil, value: viewModel.isPressed)
    }
    
    func style(
        inactiveColor: Color? = nil,
        overlayColor: Color? = nil,
        overlayOpacity: Double? = nil,
        hapticStyle: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
        hapticIntensity: Double? = nil,
        shadowEnabled: Bool? = nil,
        shadowY: CGFloat? = nil,
        shadowRadius: CGFloat? = nil
    ) -> some View {
        NoteButtonView(
            viewModel: viewModel,
            style: NoteButtonStyle(
                inactiveColor: inactiveColor ?? style.inactiveColor,
                overlayColor: overlayColor ?? style.overlayColor,
                overlayOpacity: overlayOpacity ?? style.overlayOpacity,
                hapticStyle: hapticStyle ?? style.hapticStyle,
                hapticIntensity: hapticIntensity ?? style.hapticIntensity,
                shape: style.shape,
                shadowEnabled: shadowEnabled ?? style.shadowEnabled,
                shadowY: shadowY ?? style.shadowY,
                shadowRadius: shadowRadius ?? style.shadowRadius,
                label: { style.label }
            )
        )
    }
}

extension View {
    func noteButton(_ midiNote: Int, @ViewBuilder label: @escaping () -> some View) -> some View {
        @State var isPressed = false
        return NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: $isPressed
            ),
            style: NoteButtonStyle(
                label: label
            )
        )
    }
    
    // Overload for simple string labels
    func noteButton(_ midiNote: Int, label: String? = nil) -> some View {
        @State var isPressed = false
        return NoteButtonView(
            viewModel: NoteButtonViewModel(
                noteNumbers: [midiNote],
                isPressed: $isPressed
            ),
            style: NoteButtonStyle(
                label: { label.map { Text($0) } }
            )
        )
    }
} 