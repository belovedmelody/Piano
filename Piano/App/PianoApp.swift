//
//  PianoApp.swift
//  Piano
//
//  Created by Max Mellman on 1/26/25.
//

import SwiftUI

@main
struct PianoApp: App {
    init() {
        // Initialize audio engine at launch
        _ = AudioEngine.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(.orange)
        }
    }
}
