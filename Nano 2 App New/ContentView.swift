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
    private let speechSynthesizer = SpeechSynthesizer()
    
    @State private var isReading = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(red: 33 / 255, green: 34 / 255, blue: 36 / 255))
                    .ignoresSafeArea()
                    .frame(height: 50)
                
                GeometryReader { geometry in
                    CameraPreview(textRecognizer: textRecognizer)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .ignoresSafeArea()
                        .overlay (
                        
                            // Floating button stop/play
                            HStack {
                                Spacer()
                                Button(action: {
                                    if isReading {
                                        speechSynthesizer.stop()
                                        isReading = false
                                    } else {
                                        speechSynthesizer.speak(text: textRecognizer.recognizedText)
                                        isReading = true
                                    }
                                }) {
                                    Image(systemName: isReading ? "stop.circle.fill" : "play.circle.fill")
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
                            Button {
                                self.selectedButton = .readText
                                // Perform text detection and speak recognized text
                                if !isReading {
                                    speechSynthesizer.speak(text: textRecognizer.recognizedText)
                                    isReading = true
                                } else {
                                    speechSynthesizer.stop()
                                    isReading = false
                                }
                            } label: {
                                VStack {
                                    HStack {
                                        Image(systemName: "text.viewfinder")
                                            .font(.system(size: 34))
                                        Text("Read Text")
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
                            Button {
                                self.selectedButton = .readObject
                            } label: {
                                VStack {
                                    HStack {
                                        Image(systemName: "dot.circle.viewfinder")
                                            .font(.system(size: 34))
                                        Text("Read Object")
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
}

#Preview {
    ContentView()
}

enum SelectedButton {
    case readText
    case readObject
}



//        TabView {
//            VStack{
//                Text("Page 1")
//            }
//            .tabItem {
//                Image(systemName: "text.viewfinder")
//                Text("Read Text")
//            }
//
//            VStack {
//                Text("page 2")
//            }
//            .tabItem {
//                Image(systemName: "dot.circle.viewfinder")
//                Text("Read Object")
//            }
//        }
