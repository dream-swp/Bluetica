//
//  CharacteristicsCell.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import SwiftUI

struct CharacteristicsCell: View {
    
    let isSelected = false
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Test")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
//                        .lineLimit(1)
                }
            }
            
        }
    }
}
