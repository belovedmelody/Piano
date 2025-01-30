import SwiftUI

struct KeyLabel: View {
    let text: String
    let isAccidental: Bool
    let showTopBottom: Bool
    
    init(text: String, isAccidental: Bool, showTopBottom: Bool = false) {
        self.text = text
        self.isAccidental = isAccidental
        self.showTopBottom = showTopBottom
    }
    
    var body: some View {
        ZStack {
            // Bottom layer - centered text
            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundColor(isAccidental ? 
                    Color(UIColor.systemGray3.resolvedColor(with: .init(userInterfaceStyle: .dark))) :
                    Color(UIColor.systemGray3.resolvedColor(with: .init(userInterfaceStyle: .dark))))
            
            // Top layer - optional top/bottom text
            VStack {
                Text(text)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundColor(isAccidental ? 
                        Color(UIColor.systemGray3.resolvedColor(with: .init(userInterfaceStyle: .dark))) :
                        Color(UIColor.systemGray3.resolvedColor(with: .init(userInterfaceStyle: .dark))))
                    .opacity(showTopBottom ? 1 : 0)
                
                Spacer()
                
                Text(text)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundColor(isAccidental ? 
                        Color(UIColor.systemGray3.resolvedColor(with: .init(userInterfaceStyle: .dark))) :
                        Color(UIColor.systemGray3.resolvedColor(with: .init(userInterfaceStyle: .dark))))
                    .opacity(showTopBottom ? 1 : 0)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        KeyLabel(text: "C", isAccidental: false)
        KeyLabel(text: "C♯", isAccidental: true)
        KeyLabel(text: "D", isAccidental: false, showTopBottom: true)
        KeyLabel(text: "D♯", isAccidental: true, showTopBottom: true)
    }
    .padding()
    .background(Color(.systemGray6))
} 