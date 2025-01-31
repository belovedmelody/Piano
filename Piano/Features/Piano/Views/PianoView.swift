import SwiftUI

struct PianoView: View {
    let showLabels: Bool
    let labelSystem: MusicTheory.LabelSystem
    
    var body: some View {
        VStack(spacing: 10) {
            PianoRegisterView(
                baseC: 72,  // C5
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            PianoRegisterView(
                baseC: 60,  // C4
                showLabels: showLabels,
                labelSystem: labelSystem
            )
            
            PianoRegisterView(
                baseC: 48,  // C3
                showLabels: showLabels,
                labelSystem: labelSystem
            )
        }
    }

    static func lowerFBSegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([53, 55, 57, 59], [54, 56, 58])  // F3-B3
    }
    
    static func lowerCESegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([60, 62, 64], [61, 63])  // C4-E4
    }

    static func upperFBSegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([65, 67, 69, 71], [66, 68, 70])  // F4-B4
    }
    
    static func upperCESegment() -> (whiteKeys: [Int], blackKeys: [Int]) {
        return ([72, 74, 76], [73, 75])  // C5-E5
    }
}

#Preview {
    return PianoView(
        showLabels: true,
        labelSystem: .none
    )
} 
