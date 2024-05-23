//
//  SpeechSynthezier.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 20/05/24.
//

import AVFoundation

class SpeechSynthesizer: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking: Bool = false
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        synthesizer.speak(utterance)
        isSpeaking = true
        
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    // AVSpeechSynthesizerDelegate method
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
    
}
