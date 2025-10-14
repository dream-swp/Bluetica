//
//  DeviceInfoReceivedCell.swift
//  Example
//
//  Created by Dream on 2025/10/11.
//

import SwiftUI

struct DeviceInfoReceivedCell: View {
    
    let item: ReceivedItem
    let characteristic: Characteristics?
    
    let action: () -> Void
    
    var body: some View {
         
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: item.icon)
                    .foregroundStyle(.green)
                    .font(.caption)
                    .bold()
                
                Text(item.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                Spacer()
                
                Button(action: action) {
                    Image(systemName: "doc.on.doc")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.blue.opacity(0.8)).padding(.trailing, 5)
                }
                .buttonStyle(.plain)
                
                
            }
            Text(value.isEmpty ? "无数据" : value)
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(value.isEmpty ? .bluetoothText : .primary )
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .cornerRadius(4)
                .textSelection(.enabled)
        }
    }
}

extension DeviceInfoReceivedCell {
    private var value: String {
        item.value { characteristic }
    }
}
