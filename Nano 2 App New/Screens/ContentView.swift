//
//  ContentView.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 18/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedFeature: SelectedFeature = .readText
    @StateObject var textRecognizer = TextRecognizer()
    @StateObject var objectDetector = ObjectDetector()
    @StateObject var speechSynthesizer = SpeechSynthesizer()
    
    var body: some View {
        VStack(spacing: 0) {
            SectionView(height: 50)
            
            GeometryReader { geometry in
                CameraView(
                    textRecognizer: textRecognizer,
                    objectDetector: objectDetector)
                .overlay (
                    PlayStopButton(
                        speechSynthesizer: speechSynthesizer,
                        selectedFeature: selectedFeature,
                        textRecognizer: textRecognizer,
                        objectDetector: objectDetector)
                )
            }
            
            SectionView(height: 150)
                .overlay (
                    HStack {
                        Spacer()
                        FeatureButton(
                            title: "Baca Teks",
                            iconName: "text.viewfinder",
                            isSelected: selectedFeature == .readText,
                            action: {
                                self.selectedFeature = .readText
                                speechSynthesizer.stop()
                                speechSynthesizer.speak(text: "Membaca text")
                            }
                        )
                        Spacer()
                        FeatureButton(
                            title: "Deteksi Objek",
                            iconName: "dot.circle.viewfinder",
                            isSelected: selectedFeature == .readObject,
                            action: {
                                self.selectedFeature = .readObject
                                speechSynthesizer.stop()
                                speechSynthesizer.speak(text: "Deteksi Objek")
                            }
                        )
                        Spacer()
                    }
                        .padding(.bottom, 20)
                )
        }
        
    }
}


#Preview {
    ContentView()
}


