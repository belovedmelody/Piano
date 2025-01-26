import SwiftUI
import UIKit

// MARK: - Touch Coordinator
class TouchCoordinator {
    static let shared = TouchCoordinator()
    var activeButtons: [TouchDetectingView] = []
    private var touchAssignments: [UITouch: TouchDetectingView] = [:]
    
    func registerButton(_ button: TouchDetectingView) {
        activeButtons.insert(button, at: 0)
        updateTouchAssignments()
    }
    
    func unregisterButton(_ button: TouchDetectingView) {
        activeButtons.removeAll { $0 === button }
        touchAssignments = touchAssignments.filter { $0.value !== button }
        updateTouchAssignments()
    }
    
    func updateTouch(_ touch: UITouch, phase: UITouch.Phase) {
        switch phase {
        case .began, .moved:
            touchAssignments[touch] = activeButtons.first { 
                $0.delegate?.checkTouch(touch, in: $0) == true 
            }
        case .ended, .cancelled:
            touchAssignments.removeValue(forKey: touch)
        case .regionEntered, .regionMoved, .regionExited, .stationary:
            break
        @unknown default:
            break
        }
        updateTouchAssignments()
    }
    
    private func updateTouchAssignments() {
        activeButtons.forEach { $0.currentTouches.removeAll() }
        for (touch, button) in touchAssignments {
            button.currentTouches.insert(touch)
        }
        activeButtons.forEach { $0.updateButtonState() }
    }
}

// MARK: - SwiftUI Bridge
struct TouchHandlingView: UIViewRepresentable {
    let viewModel: NoteButtonViewModel
    let shape: (CGRect) -> Path
    
    func makeUIView(context: Context) -> TouchDetectingView {
        let view = TouchDetectingView()
        view.delegate = context.coordinator
        view.isMultipleTouchEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: TouchDetectingView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel, shape: shape)
    }
    
    class Coordinator: NSObject {
        let viewModel: NoteButtonViewModel
        let shape: (CGRect) -> Path
        
        init(viewModel: NoteButtonViewModel, shape: @escaping (CGRect) -> Path) {
            self.viewModel = viewModel
            self.shape = shape
        }
        
        func checkTouch(_ touch: UITouch, in view: UIView) -> Bool {
            let location = touch.location(in: view)
            let path = shape(view.bounds)
            return path.contains(location)
        }
    }
}

// MARK: - UIKit Implementation
class TouchDetectingView: UIView {
    weak var delegate: TouchHandlingView.Coordinator?
    var currentTouches = Set<UITouch>()
    private(set) var isActive = false
    private let generator = UIImpactFeedbackGenerator(style: .rigid)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            TouchCoordinator.shared.registerButton(self)
        } else {
            TouchCoordinator.shared.unregisterButton(self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { TouchCoordinator.shared.updateTouch($0, phase: .began) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { TouchCoordinator.shared.updateTouch($0, phase: .moved) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { TouchCoordinator.shared.updateTouch($0, phase: .ended) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { TouchCoordinator.shared.updateTouch($0, phase: .cancelled) }
    }
    
    func updateButtonState() {
        let shouldBeActive = !currentTouches.isEmpty
        guard shouldBeActive != isActive else { return }
        
        isActive = shouldBeActive
        delegate?.viewModel.handlePress(isActive: shouldBeActive)
        
        if shouldBeActive {
            generator.impactOccurred(intensity: 0.67)
        }
    }
} 