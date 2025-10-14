//
//  CharacteristicsTags.swift
//  Example
//
//  Created by Dream on 2025/10/9.
//

import SwiftUI

struct CharacteristicsTags: View {

    let characteristic: Characteristics
    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                Text("权限: ")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                ForEach(Array(characteristic.tagsStyle.enumerated()), id: \.offset) { _, item in
                    CharacteristicsTag(title: item.title, color: item.color)
                }
            }
        }
    }
}

extension Characteristics {

    fileprivate var tagsStyle: [(title: String, color: Color)] {
        var style: [(title: String, color: Color)] = []
        if self.isRead { style.append(("读", .green)) }
        if self.isWrite { style.append(("写", .blue)) }
        if self.isWriteWithoutResponse { style.append(("快写 ( 无响应 )", .purple)) }
        if self.isNotify { style.append(("通知", .orange)) }
        if self.isIndicate { style.append(("指示", .red)) }
        return style
    }
}

private struct CharacteristicsTag: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.caption2)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.2))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
