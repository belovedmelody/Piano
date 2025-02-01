//
//  PianoApp.swift
//  Piano
//
//  Created by Max Mellman on 1/26/25.
//
// Piano (by belovedmelody) is a piano for iPhone (and maybe iOS at large eventually) that strives to be as simple and accessible as the built-in iOS keyboard.

// The key insight is that a piano made for your thumbs (and other fingertips—up to five) is easier to play at a small size in portrait orientation than it is to play at a larger size in landscape orientation. And because of its smaller size, three octaves can fit on the screen at once, allowing for a range that generally fits on the grand staff, covering bass, middle, and treble registers.

// To make the piano more accessible and playable at a small size, it also includes a Scale View, which distills the entire chromatic octave into just the seven diatonic tones of a user-specified key signature (based on the tonic variable). 

// The ScaleView is a variation on another educational musical instrument app I’ve been working on called ilophone—a xylophone for your iPhone which allows you to add or remove diatonic tones from the visible key set, and can transpose into different key signatures.

// The whole app is based around one fundamental component, and that is the noteButton. NoteButton derives from the PianoKeyboard package by developer (and rock musician) Gary Newby. PianoKeyboard is special because it’s the most accessible SwiftUI-based view that allows for sliding between notes (surprisingly hard to do!). Note that it is a SwiftUI wrapper for a UIKit-based touchmethod system.

// I love this app very much, and I hope that people everywhere will appreciate and enjoy having a pocket piano that is (in my opinion) the most playable instrument yet for iPhone. Whether they use it as a reference tool, or find themselves jamming along with their favorite songs while listening to music on the subway, people will find Piano to be a simple and versatile tool that puts the user first.

// As Piano evolves, I expect to add a recording feature, as well as a music notation system with autocorrect.lovedmelody) is piano for iPhone (and maybe iOS at large eventually) that strives to be as simple and accessible

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
