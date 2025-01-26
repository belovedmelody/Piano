import SwiftUI
import UIKit  // For UIImpactFeedbackGenerator

/// A customizable button that plays MIDI notes when pressed.
/// 
/// NoteButton adapts to its container's size by default, but can be explicitly sized using SwiftUI frame modifiers:
/// ```
/// noteButton(60)                           // Fills available space
/// noteButton(60).frame(width: 100)         // Fixed width
/// noteButton(60).frame(maxHeight: 80)      // Maximum height
/// ```
///
/// Customize appearance using NoteButtonStyle:
/// ```
/// noteButton(60, style: NoteButtonStyle(
///     inactiveColor: .blue,                // Base color
///     overlayColor: .white,                // Press effect color
///     overlayOpacity: 0.2,                 // Press effect strength
///     hapticStyle: .rigid,                 // Haptic feedback style
///     hapticIntensity: 0.67,              // Haptic feedback strength
///     shape: { rect in ... },              // Custom shape
///     label: {                             // Optional custom view as label
///         VStack {
///             Text("C")
///             Text("4").font(.caption)
///         }
///     }
/// ))
/// ```
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

/// A customizable button that plays MIDI notes when pressed.
/// 
/// NoteButton adapts to its container's size by default, but can be explicitly sized using SwiftUI frame modifiers:
/// ```
/// noteButton(60)                           // Fills available space
/// noteButton(60).frame(width: 100)         // Fixed width
/// noteButton(60).frame(maxHeight: 80)      // Maximum height
/// ```
///
/// Customize appearance using NoteButtonStyle:
/// ```
/// noteButton(60, style: NoteButtonStyle(
///     inactiveColor: .blue,                // Base color
///     overlayColor: .white,                // Press effect color
///     overlayOpacity: 0.2,                 // Press effect strength
///     hapticStyle: .rigid,                 // Haptic feedback style
///     hapticIntensity: 0.67,              // Haptic feedback strength
///     shape: { rect in ... },              // Custom shape
///     label: {                             // Optional custom view as label
///         VStack {
///             Text("C")
///             Text("4").font(.caption)
///         }
///     }
/// ))
/// ```
struct NoteButtonView<Label: View>: View {
    @StateObject var viewModel: NoteButtonViewModel
    let style: NoteButtonStyle<Label>
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                style.shape(geometry.frame(in: .local))
                    .fill(style.inactiveColor)
                    .overlay(
                        style.shape(geometry.frame(in: .local))
                            .fill(style.overlayColor.opacity(viewModel.isPressed ? style.overlayOpacity : 0))
                    )
                    .shadow(
                        color: .black.opacity(style.shadowEnabled ? 0.25 : 0),
                        radius: style.shadowRadius,
                        x: 0,
                        y: style.shadowY
                    )
                    .animation(nil, value: viewModel.isPressed)
            }
            
            TouchHandlingView(viewModel: viewModel, shape: style.shape)
            
            if let label = style.label {
                label
                    .font(.body)
                    .foregroundColor(.primary)
                    .animation(nil, value: viewModel.isPressed)
            }
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