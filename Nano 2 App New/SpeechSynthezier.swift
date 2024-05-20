//
//  SpeechSynthezier.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 20/05/24.
//

import AVFoundation

class SpeechSynthesizer {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    
}
