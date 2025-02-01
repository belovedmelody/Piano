// The special label view scaleView toneBars.
// Contain special tags for sharps and flats, as an alternative to changing the color of the whole bar.

import SwiftUI

struct Tag: View {
    let text: String  // Expects "♯" or "♭"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(UIColor.systemGray5.resolvedColor(with: .init(userInterfaceStyle: .light))))
                .frame(width: 20, height: 20)
            
            Text(text)
                .font(.subheadline)
                .fontDesign(.rounded)
                .foregroundColor(Color(.systemGray))
                .offset(y: 1)  // Push text down by 1pt
        }
    }
}

struct ToneBarLabel: View {
    let text: String
    let isAccidental: Bool
    let showLabels: Bool  // For note name visibility
    let usesFlats: Bool
    
    private var cleanText: String {
        text.replacingOccurrences(of: "♯", with: "")
            .replacingOccurrences(of: "♭", with: "")
    }
    
    init(text: String, isAccidental: Bool, showLabels: Bool = false, usesFlats: Bool = false) {
        self.text = text
        self.isAccidental = isAccidental
        self.showLabels = showLabels
        self.usesFlats = usesFlats
    }
    
    var body: some View {
        ZStack {
            // Center text (only visible when showLabels is true)
            if showLabels {
                Text(cleanText)
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundColor(Color(.systemGray))
            }
            
            // Tags (always visible for accidentals)
            VStack {
                Tag(text: "♯")
                    .opacity((isAccidental && !usesFlats) ? 1 : 0)
                
                Spacer()
                
                Tag(text: "♭")
                    .opacity((isAccidental && usesFlats) ? 1 : 0)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ToneBarLabel(text: "D♯", isAccidental: true, showLabels: true)
    }
    .padding()
    .background(Color(.systemGray6))
} 
