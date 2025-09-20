//
//  BluetoothPlaceholderView.swift
//  Example
//
//  Created by Dream on 2025/9/20.
//

import SwiftUI

struct BluetoothPlaceholderView: View {

    let info: () -> (icon: String, title: String, sub: String)
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(sub)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    
    }
}

extension BluetoothPlaceholderView {
    private var icon: String {
        info().icon
    }
    
    private var title: String {
        info().title
    }
    
    private var sub: String {
        info().sub
    }
}

#Preview {
    
    BluetoothPlaceholderView {
        ("antenna.radiowaves.left.and.right.slash", "暂无发现设备", "请点击\"开始扫描\"按钮搜索附近的蓝牙设备")
    }
}
