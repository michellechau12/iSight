//
//  ContentView.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 18/05/24.
//

import SwiftUI


struct ContentView: View {
    @State var selectedButton: SelectedButton = .readText
    
    var body: some View {
        VStack (spacing: 0) {
            Rectangle()
                .fill(Color(red: 33 / 255, green: 34 / 255, blue: 36 / 255))
                .ignoresSafeArea()
                .frame(height: 50)
            
            GeometryReader { geometry in
                CameraPreview()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .ignoresSafeArea()
            }
            
            Rectangle()
                .fill(Color(red: 33 / 255, green: 34 / 255, blue: 36 / 255))
                .ignoresSafeArea()
                .frame(height: 150)
                .overlay (
                    HStack {
                        Spacer()
                        Button {
                            self.selectedButton = .readText
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




#Preview {
    ContentView()
}

enum SelectedButton {
    case readText
    case readObject
    // Add more cases here for additional buttons
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
