//
//  BluetoothTarget.swift
//  Example
//
//  Created by Dream on 2025/9/12.
//

import SwiftUI

enum BluetoothItmes: String, CaseIterable, Identifiable {
    var id: Self { self }
    case scan, device, setting
    
    
    static var itmes: [BluetoothItmes] {
        BluetoothItmes.allCases
    }
    
    var title: String {
        switch self {
        case .scan:
            "蓝牙扫描"
        case .device:
            "设备详情"
        case .setting:
            "系统设置"
        }
    }
    
    var image: String {
        switch self {
        case .scan:
            "repeat.circle"
        case .device:
            "link.circle"
        case .setting:
            "info.circle"
        }
    
    }
    
    @ViewBuilder var target: some View {
        switch self {
        case .scan:
            BluetoothMainScanView()
        case .device:
            BluetoothMainDeviceView()
        case .setting:
            BluetoothMainSettingView()
        }
    }
}
