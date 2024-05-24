//
//  PlayStopButton.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 23/05/24.
//

import SwiftUI

struct PlayStopButton: View {
    @ObservedObject var speechSynthesizer: SpeechSynthesizer
    private let selectedFeature: SelectedFeature
    private let textRecognizer: TextRecognizer
    private let objectDetector: ObjectDetector
    
    init(speechSynthesizer: SpeechSynthesizer, selectedFeature: SelectedFeature, textRecognizer: TextRecognizer, objectDetector: ObjectDetector) {
        self.speechSynthesizer = speechSynthesizer
        self.selectedFeature = selectedFeature
        self.textRecognizer = textRecognizer
        self.objectDetector = objectDetector
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                if speechSynthesizer.isSpeaking {
                    speechSynthesizer.stop()
                } else {
                    let textToSpeak = selectedFeature == .readText ? textRecognizer.recognizedText : objectDetector.detectedObjects
                    
                    speechSynthesizer.speak(text: textToSpeak)
                    
                    if textToSpeak == "" {
                        speechSynthesizer.speak(text: selectedFeature == .readText ? "Tidak menemukan text" : "Tidak menemukan objek")
                    }
                }
            }) {
                Image(systemName: speechSynthesizer.isSpeaking ? "stop.circle.fill" : "play.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 100))
                    .foregroundColor(speechSynthesizer.isSpeaking ? .red : Color(.primaryGreen))
            }
            .padding()
        }
    }
}

#Preview {
    PlayStopButton(
        speechSynthesizer: SpeechSynthesizer(),
        selectedFeature: .readText,
        textRecognizer: TextRecognizer(),
        objectDetector: ObjectDetector()
    )
}
