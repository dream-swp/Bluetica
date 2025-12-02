//
//  BlueticaConvertMode.swift
//  Bluetica
//
//  Created by Dream on 2025/10/14.
//

import Foundation

/// 蓝牙数据转换枚举
/// 处理各种格式的字符串到 Data 的转换
enum BlueticaConvertData {

    /// 普通字符串转换
    case data(String, String.Encoding)
    /// 十六进制字符串转换
    case hex(String)
    /// 十进制字符串转换
    case decimal(String)
    /// 二进制字符串转换
    case binary(String)
    /// Base64 字符串转换
    case base64(String, Data.Base64DecodingOptions = [])

    /// 获取原始字符串值
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

    /// 转换为 Data 对象
    var data: Data {
        switch self {
        case .data(_, let encoding): data(filter.value, encoding: encoding)
        case .hex: hex(self.filter.value)
        case .decimal: Data(decimals)
        case .binary: Data(binarys)
        case .base64(_, let options): base64(filter.value, options: options)
        }
    }

    /// 获取原始分割后的字符串数组
    var original: [String] {
        switch self {
        case .decimal, .binary:
            filter.value.components(separatedBy: self.separators).filter { !$0.isEmpty }
        default: [filter.value]
        }
    }

}

extension BlueticaConvertData {
    /// 验证字符集
    var verify: CharacterSet {
        switch self {
        case .hex:
            CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
        case .decimal:
            CharacterSet(charactersIn: " ,;|-_*\t\n")
        default: .whitespacesAndNewlines

        }
    }

    /// 分隔符字符集
    var separators: CharacterSet {

        switch self {
        case .decimal: CharacterSet(charactersIn: " ,;|-_*\t\n")
        case .binary: CharacterSet(charactersIn: " ,;|-_*\t\n")
        default: []
        }
    }

    /// 需要替换移除的字符串数组
    var replacing: [String] {

        switch self {
        case .hex: [" ", "-", ":", "0x", "0X", "\\x", "#"]
        case .decimal: ["[", "]", "{", "}", "\"", "'"]
        case .base64: ["\n", "\r", " "]
        default: []
        }

    }

    /// 过滤并清理字符串
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

    /// 将字符串转换为 Data
    /// - Parameters:
    ///   - value: 要转换的字符串
    ///   - encoding: 字符串编码
    /// - Returns: Data 对象
    func data(_ value: String, encoding: String.Encoding) -> Data {
        value.data(using: encoding) ?? Data()
    }

    /// 将十六进制字符串转换为 Data
    /// - Parameter value: 十六进制字符串
    /// - Returns: Data 对象
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

    /// 将十进制字符串转换为字节数组
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

    /// 将二进制字符串转换为字节数组
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

    /// 将 Base64 字符串转换为 Data
    /// - Parameters:
    ///   - value: Base64 字符串
    ///   - options: 解码选项
    /// - Returns: Data 对象
    func base64(_ value: String, options: Data.Base64DecodingOptions = []) -> Data {
        Data(base64Encoded: value.trimmingCharacters(in: self.verify), options: options) ?? Data()
    }

}
