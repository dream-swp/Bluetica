//
//  CharacteristicWriteItem.swift
//  Example
//
//  Created by Dream on 2025/10/12.
//


enum WriteDataItem: String, CaseIterable, Identifiable {
    var id: Self { self }
    case string = "字符串"
    case hex = "十六进制"
    case decimal = "十进制"
    case binary = "二进制"
    case base64 = "Base64"
    
    var icon: String {
        switch self {
        case .hex: "number.square"
        case .decimal: "numbers.rectangle"
        case .binary: "01.square"
        case .string: "a.square"
        case .base64: "b.square"
        }
    }
}

enum WriteModeItem: String, CaseIterable, Identifiable {
    var id: Self { self }
    case writeResponse = "写入 (响应) "
    case writeWithoutResponse = "写入 (无响应)"
    
    var icon: String {
        switch self {
        case .writeResponse: "highlighter.badge.ellipsis"
        case .writeWithoutResponse: "highlighter"
        }
    }
    
}
