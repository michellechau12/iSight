//
//  Section.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 23/05/24.
//

import SwiftUI

struct SectionView: View {
    var height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color(red: 33 / 255, green: 34 / 255, blue: 36 / 255))
            .ignoresSafeArea()
            .frame(height: height)
    }
}

#Preview {
    SectionView(height: 100)
}
