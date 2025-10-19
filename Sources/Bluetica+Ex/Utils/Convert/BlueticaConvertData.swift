//
//  BlueticaConvertMode.swift
//  Bluetica
//
//  Created by Dream on 2025/10/14.
//

import Foundation

enum BlueticaConvertData {

    case data(String, String.Encoding)
    case hex(String)
    case decimal(String)
    case binary(String)
    case base64(String, Data.Base64DecodingOptions = [])

    var value: String {
        switch self {
        case .data(let value, _),
            .hex(let value),
            .decimal(let value),
            .binary(let value),
            .base64(let value, _):
            value
        }
    }

    var data: Data {
        switch self {
        case .data(_, let encoding): data(filter.value, encoding: encoding)
        case .hex: hex(self.filter.value)
        case .decimal: Data(decimals)
        case .binary: Data(binarys)
        case .base64(_, let options): base64(filter.value, options: options)
        }
    }

    var original: [String] {
        switch self {
        case .decimal, .binary:
            filter.value.components(separatedBy: self.separators).filter { !$0.isEmpty }
        default: [filter.value]
        }
    }

}

extension BlueticaConvertData {
    var verify: CharacterSet {
        switch self {
        case .hex:
            CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
        case .decimal:
            CharacterSet(charactersIn: " ,;|-_*\t\n")
        default: .whitespacesAndNewlines

        }
    }

    var separators: CharacterSet {

        switch self {
        case .decimal: CharacterSet(charactersIn: " ,;|-_*\t\n")
        case .binary: CharacterSet(charactersIn: " ,;|-_*\t\n")
        default: []
        }
    }

    var replacing: [String] {

        switch self {
        case .hex: [" ", "-", ":", "0x", "0X", "\\x", "#"]
        case .decimal: ["[", "]", "{", "}", "\"", "'"]
        case .base64: ["\n", "\r", " "]
        default: []
        }

    }

    var filter: Self {
        switch self {
        case .hex(var value):
             _ = self.replacing.compactMap {
                value = value.replacingOccurrences(of: $0, with: "")
            }
            return .hex(value)
        case .decimal(var value):
            let _ = self.replacing.compactMap {
                value = value.replacingOccurrences(of: $0, with: "")
            }
            return .decimal(value)
        case .base64(var value, let options):
            _ = self.replacing.compactMap {
                value = value.replacingOccurrences(of: $0, with: "")
            }
            return .base64(value, options)
        default: return self
        }
    }
}

extension BlueticaConvertData {

    func data(_ value: String, encoding: String.Encoding) -> Data {
        value.data(using: encoding) ?? Data()
    }

    func hex(_ value: String) -> Data {
        var data = Data()
        guard value.uppercased().rangeOfCharacter(from: self.verify.inverted) == nil else {
            return data
        }
        for index in stride(from: 0, to: value.count, by: 2) {
            let startIndex = value.index(value.startIndex, offsetBy: index)
            let endIndex = value.index(startIndex, offsetBy: 2)
            let byteString = String(value[startIndex..<endIndex])
            if let byte = UInt8(byteString, radix: 16) {
                data.append(byte)
            }
        }
        return data
    }

    var decimals: [UInt8] {

        switch self {
        case .decimal:
            let decimals = original
            if decimals.verify.isDecimal == false { return [] }

            let reslut = decimals.compactMap {
                if let number = Int($0), (0..<256).contains(number) { return UInt8(number) }
                return UInt8()
            }
            return reslut
        default: return []
        }
    }

    var binarys: [UInt8] {
        switch self {
        case .binary:
            let binarys = original
            if binarys.verify.isBinary == false { return [] }

            let reslut = binarys.compactMap {
                let trimmed = $0.trimmingCharacters(in: self.verify)
                return UInt8(trimmed, radix: 2) ?? UInt8()
            }
            return reslut
        default: return []
        }
    }

    func base64(_ value: String, options: Data.Base64DecodingOptions = []) -> Data {
        Data(base64Encoded: value.trimmingCharacters(in: self.verify), options: options) ?? Data()
    }

}
