//
//  Bluetooth+.swift
//  Example
//
//  Created by Dream on 2025/9/9.
//

import Foundation
import CoreBluetooth

import SwiftUI

extension Int {

    var rssiColor: Color {
        switch self {
        case -50..<0:
            return .green
        case -70 ..< -50:
            return .orange
        case -90 ..< -70:
            return .red
        default:
            return .gray
        }
    }
}


extension String {
    
    var deviceIcon: Self {
        switch self.lowercased() {
        case let string where string.contains("phone") || string.contains("iphone"):
            "iphone"
        case let string where string.contains("ipad"):
            "ipad"
        case let string where string.contains("watch"):
            "applewatch"
        case let string where string.contains("mac"):
            "laptopcomputer"
        case let string where string.contains("air"):
            "airpods.pro"
        default:
            "personalhotspot"
        }
    }
    
    func deviceIcon(_ handler: () -> (Bool)) -> Self {
        
        switch self.lowercased() {
        case let string where string.contains("phone") || string.contains("iphone"):
            "iphone"
        case let string where string.contains("ipad"):
            "ipad"
        case let string where string.contains("watch"):
            "applewatch"
        case let string where string.contains("mac"):
            "laptopcomputer"
        case let string where string.contains("air"):
            "airpods.pro"
        default:
            handler() ?  "bolt.circle.fill" : "bolt.slash.circle.fill"
        }
        
    }
    
    var serviceInfo: (image: String, title: String) {
        switch self.uppercased() {
        case "180F": ("battery.100percent.circle", "电池服务")
        case "180A": ("info.circle", "设备信息")
        case "1800": ("globe", "通用访问")
        case "1801": ("gear.circle", "通用属性")
        case "1804": ("repeat.circle", "传输发现")
        default: ("arrow.trianglehead.2.clockwise.rotate.90.circle", self)
        }
    }
}



extension UUID {
    
    var string: String { self.uuidString }
}

extension CBUUID {
    
    var string: String { self.uuidString }
}

extension Bool {
    
    var connectedColor: Color {
        self ? .green : .gray
    }
    
    var statusCircleColor: Color {
        self ? .green : .gray
    }
    
    var statusTextColor: Color {
        self ? .gray : .orange
    }
    
}


extension View {
    
    var divider: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .bluetoothStatusCardDivider, .clear]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}
