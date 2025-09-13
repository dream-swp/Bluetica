//
//  Bluetooth+.swift
//  Example
//
//  Created by Dream on 2025/9/9.
//

import Foundation

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
}



extension UUID {
    
    var string: String {
        self.uuidString
    }
}

extension Bool {
    
    var connectedColor: Color {
        self ? .green : .blue
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
