import SwiftUI

/// Stores the x-coordinate boundaries for piano keys
struct KeyBoundaries: Equatable {
    let keyIndex: Int
    let leftEdge: CGFloat
    let rightEdge: CGFloat
}

/// A preference key to collect key boundary information
struct KeyBoundaryPreferenceKey: PreferenceKey {
    static var defaultValue: [KeyBoundaries] = []
    
    static func reduce(value: inout [KeyBoundaries], nextValue: () -> [KeyBoundaries]) {
        value.append(contentsOf: nextValue())
    }
}

/// An invisible view that records the x-coordinates of its boundaries
struct KeyBoundaryRecorder: View {
    let keyIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(
                    key: KeyBoundaryPreferenceKey.self,
                    value: [
                        KeyBoundaries(
                            keyIndex: keyIndex,
                            leftEdge: geometry.frame(in: .global).minX,
                            rightEdge: geometry.frame(in: .global).maxX
                        )
                    ]
                )
        }
    }
} 