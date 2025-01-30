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
    let showTopBottom: Bool
    let usesFlats: Bool
    
    private var cleanText: String {
        text.replacingOccurrences(of: "♯", with: "")
            .replacingOccurrences(of: "♭", with: "")
    }
    
    init(text: String, isAccidental: Bool, showTopBottom: Bool = false, usesFlats: Bool = false) {
        self.text = text
        self.isAccidental = isAccidental
        self.showTopBottom = showTopBottom
        self.usesFlats = usesFlats
    }
    
    var body: some View {
        ZStack {
            // Center text (always visible)
            Text(cleanText)  // Use cleanText instead of text
                .font(.body)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundColor(Color(.systemGray))
            
            // Optional top/bottom text
            VStack {
                Tag(text: "♯")
                    .opacity((showTopBottom && isAccidental && !usesFlats) ? 1 : 0)
                
                Spacer()
                
                Tag(text: "♭")
                    .opacity((showTopBottom && isAccidental && usesFlats) ? 1 : 0)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ToneBarLabel(text: "D♯", isAccidental: true, showTopBottom: true)
    }
    .padding()
    .background(Color(.systemGray6))
} 
