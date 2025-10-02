//
//  CharacteristicsListView.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import SwiftUI

// MARK: - CharacteristicsListView
struct CharacteristicsListView: View {
    
    var characteristics: [Characteristics]
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                
                ForEach(characteristics, id: \.id) { group in
                    VStack(alignment: .leading, spacing: 12) {
                        
                        headView
                        listView
                    }
                }
            }
        }
        .padding(.vertical, 16)
       
    }
}

extension CharacteristicsListView {

    private var headView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("12312312")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Text("10")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var listView: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible(), spacing: 8)
        ], spacing: 8) {
            Text("123123")
//            ForEach(group.characteristics) { characteristic in
//                CharacteristicCard(
//                    characteristic: characteristic,
//                    isSelected: selectedCharacteristic?.id == characteristic.id
//                ) {
//                    // 选择特征并自动关闭窗口
//                    selectedCharacteristic = characteristic
//                    dismiss()
//                }
//            }
        }
        .padding(.horizontal, 16)
    }
    
//    private var cell(() -> sel): some View {
//        
//    }
}
