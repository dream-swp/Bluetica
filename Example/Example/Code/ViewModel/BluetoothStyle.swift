//
//  BluetoothViewStyle.swift
//  Example
//
//  Created by Dream on 2025/9/2.
//

import SwiftUI

enum BluetoothStyle: CaseIterable {

    static var allCases: [BluetoothStyle] {
        [.text(""), .icon(""), .command(""), .color(Color.clear), .font(Font.system(size: .zero)), colors([])]
    }

    case text(String)
    case icon(String)
    case command(String)
    case color(Color)
    case font(Font)
    case colors([Color])

}

extension BluetoothStyle {

    var icon: String {
        switch self {
        case .icon(let value): value
        default: ""
        }
    }

    var text: String {
        switch self {
        case .text(let value): value
        default: ""
        }
    }

    var color: Color {
        switch self {
        case .color(let value): value
        default: Color.clear
        }
    }

    var font: Font {
        switch self {
        case .font(let value): value
        default: Font.system(size: .zero)
        }
    }

    var colors: [Color] {
        switch self {
        case .colors(let value): value
        default: []
        }
    }

    var command: String {
        switch self {
        case .command(let value): value
        default: ""
        }
    }
}
