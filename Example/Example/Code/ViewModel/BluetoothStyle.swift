//
//  BluetoothViewStyle.swift
//  Example
//
//  Created by Dream on 2025/9/2.
//


import SwiftUI

enum BluetoothStyle: CaseIterable {

    static var allCases: [BluetoothStyle] {
        [.text(""), .icon(""), .color(Color.clear), .font(Font.system(size: .zero)), colors([])]
    }

    case text(String)
    case icon(String)
    case color(Color)
    case font(Font)
    case colors([Color])

    
}

extension BluetoothStyle {
    
    var icon: String {
        switch self {
        case .icon(let value):
            return value
        default:
            return ""
        }
    }

    var text: String {
        switch self {
        case .text(let value):
            return value
        default:
            return ""
        }
    }

    var color: Color {
        switch self {
        case .color(let value):
            return value
        default:
            return Color.clear
        }
    }

    var font: Font {
        switch self {
        case .font(let value):
            return value
        default:
            return Font.system(size: .zero)
        }
    }

    var colors: [Color] {
        switch self {
        case .colors(let value):
            return value
        default:
            return []
        }
    }
}
