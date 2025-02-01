// A simplwe sine wave synthesizer, specifying midi value, velocity (always max), and channel

import AVFoundation

class AudioEngine: ObservableObject {
    static let shared = AudioEngine()
    private let engine = AVAudioEngine()
    private let sampler = AVAudioUnitSampler()
    
    init() {
        setupAudioEngine()
    }
    
    private func setupAudioEngine() {
        engine.attach(sampler)
        engine.connect(sampler, to: engine.mainMixerNode, format: nil)

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, 
                                                          options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            try engine.start()
        } catch {
            print("AudioEngine setup failed: \(error)")
        }
    }
    
    func noteOn(noteNumber: Int) {
        sampler.startNote(UInt8(noteNumber), withVelocity: 127, onChannel: 0)
    }
    
    func noteOff(noteNumber: Int) {
        sampler.stopNote(UInt8(noteNumber), onChannel: 0)
    }
} 