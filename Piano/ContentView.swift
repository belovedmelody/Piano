import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PianoView()
                .frame(maxHeight: 200)  // Keep height constraint only
                .padding()
                .background(Color(.systemGray4))
        }
    }
}

#Preview {
    ContentView()
} 