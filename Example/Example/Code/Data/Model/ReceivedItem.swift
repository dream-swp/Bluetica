//
//  ReceivedItem.swift
//  Example
//
//  Created by Dream on 2025/10/11.
//

enum ReceivedItem: String, Identifiable, CaseIterable {

    var id: Self { self }
    case bytes = "原始字节数"
    case hexBig = "十六进制 (大写)"
    case hexSmall = "十六进制 (小写)"
    case decimal = "十进制"
    case binary = "二进制"
    case string = "UTF-8 字符串"
    case ascii = "ASCII 显示"
    case base64 = "Base64"

    func value(_ handler: () -> Characteristics?) -> String {

        guard let characteristics = handler() else { return "" }

        switch self {
        case .bytes: return "\(characteristics.data.count) bytes"
        case .hexBig: return characteristics.hexBig
        case .hexSmall: return characteristics.hexSmall
        case .decimal: return characteristics.decimal
        case .binary: return characteristics.binary
        case .string: return characteristics.string
        case .ascii: return characteristics.ascii
        case .base64: return characteristics.base64
        }

    }

    var icon: String {
        switch self {
        case .bytes: "number"
        case .hexBig: "number.square"
        case .hexSmall: "number.square.fill"
        case .decimal: "textformat.123"
        case .binary: "01.square"
        case .string: "textformat"
        case .ascii: "textformat.abc"
        case .base64: "textformat.size"
        }
    }
}

