//
//  FeatureButton.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 23/05/24.
//

import SwiftUI

import SwiftUI

struct FeatureButton: View {
    let title: String
    let iconName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                HStack {
                    Image(systemName: iconName)
                        .font(.system(size: 46))
                    Text(title)
                        .font(.system(size: 24))
                }
                if isSelected {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 10))
                }
            }
        }
        .foregroundColor(isSelected ? Color(.primaryGreen) : .white)
        .fontWeight(.bold)
    }
}

#Preview {
    FeatureButton(
        title: "Baca Teks",
        iconName: "text.viewfinder",
        isSelected: true,
        action: {}
    )
}
