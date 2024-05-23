//
//  ContentView.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 18/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedButton: SelectedButton = .readText
    @StateObject var textRecognizer = TextRecognizer()
    @StateObject var objectDetector = ObjectDetector()
    private let speechSynthesizer = SpeechSynthesizer()
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color(red: 33 / 255, green: 34 / 255, blue: 36 / 255))
                .ignoresSafeArea()
                .frame(height: 50)
            
            GeometryReader { geometry in
                CameraPreview(textRecognizer: textRecognizer, objectDetector: objectDetector)
                    .overlay (
                        // stop/play button floating
                        HStack {
                            Spacer()
                            Button(action: {
                                if speechSynthesizer.isSpeaking {
                                    speechSynthesizer.stop()
                                } else {
                                    
                                    let textToSpeak = selectedButton == .readText ? textRecognizer.recognizedText : objectDetector.detectedObjects
                                    
                                    speechSynthesizer.speak(text: textToSpeak)
                                    
                                    if textToSpeak == "" {
                                        
                                        speechSynthesizer.speak(text: selectedButton == .readText ? "Tidak menemukan text" : "Tidak menemukan objek")
                                    }
                                }
                            }) {
                                Image(systemName: speechSynthesizer.isSpeaking ? "stop.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 70))
                                    .foregroundColor(.blue)
                            }
                            .padding()
                        }
                    )
            }
            Rectangle()
                .fill(Color(red: 33 / 255, green: 34 / 255, blue: 36 / 255))
                .ignoresSafeArea()
                .frame(height: 150)
                .overlay(
                    HStack {
                        Spacer()
                        //button 1
                        Button {
                            self.selectedButton = .readText
                            speechSynthesizer.stop()
                            speechSynthesizer.speak(text: "Membaca text")
                            
                        } label: {
                            VStack {
                                HStack {
                                    Image(systemName: "text.viewfinder")
                                        .font(.system(size: 46))
                                    Text("Baca Teks")
                                        .font(.system(size: 24))
                                }
                                if selectedButton == .readText {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 10))
                                }
                            }
                        }
                        .foregroundColor(selectedButton == .readText ? .blue : .white)
                        .fontWeight(.bold)
                        Spacer()
                        
                        //button 2
                        Button {
                            self.selectedButton = .readObject
                            speechSynthesizer.stop()
                            speechSynthesizer.speak(text: "Deteksi Objek")
                        } label: {
                            VStack {
                                HStack {
                                    Image(systemName: "dot.circle.viewfinder")
                                        .font(.system(size: 46))
                                    Text("Deteksi Objek")
                                        .font(.system(size: 24))
                                }
                                if selectedButton == .readObject {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 10))
                                }
                            }
                        }
                        .foregroundColor(selectedButton == .readObject ? .blue : .white)
                        .fontWeight(.bold)
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

enum SelectedButton {
    case readText
    case readObject
}
