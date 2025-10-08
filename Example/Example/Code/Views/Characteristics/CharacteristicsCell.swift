//
//  CharacteristicsCell.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import SwiftUI
import CoreBluetooth

struct CharacteristicsCell: View {

    let characteristic: Characteristics
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(characteristic.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .lineLimit(3)

                    
                        Text(characteristic.uuid)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()

                    EmptyView().toggle(isSelected) { _ in
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title3)
                    }
                }
                
                CharacteristicsTags(characteristic: characteristic)
            }
            .padding(12)
            .background(

                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? .blue.opacity(0.1) : .bluetoothCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? .blue : .clear, lineWidth: 2)
                    )
            )

        }
        .buttonStyle(.plain)
    }
}

private struct CharacteristicsTags: View {
    
    let characteristic: Characteristics
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(Array(characteristic.tagsStyle.enumerated()), id: \.offset) {  _, item in
                    PropertyTag(title: item.title, color: item.color)
                }
            }
        }
    }
}

private extension Characteristics {
    
    var tagsStyle: [(title: String, color: Color)] {
        var style: [(title: String, color: Color)] = []
        if self.isRead {  style.append(("读", .green)) }
        if self.isWrite {  style.append(("写", .blue)) }
        if self.isWriteWithoutResponse {  style.append(("快写", .purple)) }
        if self.isNotify {  style.append(("通知", .orange)) }
        if self.isIndicate {  style.append(("指示", .red)) }
        return style
    }
}

private struct PropertyTag: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.caption2)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.2))  // 20%透明度背景
            .foregroundColor(color)  // 完整颜色文字
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

private extension CBCharacteristicProperties {
    
     var tags: [(title: String, color: Color)] {
        var tags: [(title: String, color: Color)] = []
        if self.contains(.read) { tags.append(("读", .green)) }
        if self.contains(.write) { tags.append(("写", .blue)) }
        if self.contains(.writeWithoutResponse) { tags.append(("快写", .purple)) }
        if self.contains(.notify) { tags.append(("通知", .orange)) }
        if self.contains(.indicate) { tags.append(("指示", .red)) }
        return tags
    }
}
