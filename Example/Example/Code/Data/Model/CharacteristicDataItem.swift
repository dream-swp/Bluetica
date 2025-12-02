//
//  ReceivedItem.swift
//  Example
//
//  Created by Dream on 2025/10/11.
//

enum CharacteristicDataItem: String, Identifiable, CaseIterable {

    var id: Self { self }
    case bytes = "原始字节数"
    case hexBig = "十六进制 (大写)"
    case hexSmall = "十六进制 (小写)"
    case decimal = "十进制"
    case binary = "二进制"
    case string = "UTF-8 字符串"
    case ascii = "ASCII 显示"
    case base64 = "Base64"

    func value(_ handler: () -> CharacteristicData?) -> String {

        guard let data = handler() else { return "" }

        switch self {
        case .bytes: return "\(data.data.count) bytes"
        case .hexBig: return data.hexBig
        case .hexSmall: return data.hexSmall
        case .decimal: return data.decimal
        case .binary: return data.binary
        case .string: return data.value
        case .ascii: return data.ascii
        case .base64: return data.base64
        }

    }

    var icon: String {
        switch self {
        case .bytes: "bitcoinsign.square"
        case .hexBig: "number.square"
        case .hexSmall: "number.square.fill"
        case .decimal: "numbers.rectangle"
        case .binary: "01.square"
        case .string: "a.square"
        case .ascii: "c.square"
        case .base64: "b.square"
        }
    }
}
