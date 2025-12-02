//
//  BlueticaConvertValue.swift
//  Bluetica
//
//  Created by Dream on 2025/10/15.
//

import Foundation

/// 蓝牙数据值转换枚举
/// 处理 Data 到各种格式字符串的转换
enum BlueticaConvertValue {

    /// 转换为普通字符串
    case data(Data, String.Encoding)
    /// 转换为十六进制字符串
    case hex(Data, Bool, String)
    /// 转换为十进制字符串
    case decimal(Data, String)
    /// 转换为二进制字符串
    case binary(Data, Int, String)
    /// 转换为 ASCII 字符串
    case ascii(Data, String)
    /// 转换为 Base64 字符串
    case base64(Data, Data.Base64EncodingOptions)

    /// 转换为字符串值
    var value: String {
        switch self {
        case .data(let data, let encoding):
            String(data: data, encoding: encoding) ?? ""
        case .hex(let data, let isUppercased, let separator):
            data.map { String(format: isUppercased ? "%02X" : "%02x", $0) }.joined(separator: separator)
        case .decimal(let data, let separator):
            data.map { String($0) }.joined(separator: separator)
        case .binary(let data, let pad, let separator):
            data.map { String($0, radix: 2).pad(pad) }.joined(separator: separator)
        case .ascii(let data, let join):
            data.map { (32...126).contains($0) ? String(Character(UnicodeScalar($0))) : join }.joined()
        case .base64(let data, let options):
            data.base64EncodedString(options: options)
        }
    }

    /// 转换为字节数组
    var bytes: [UInt8] {
        switch self {
        case .data(let data, _),
            .hex(let data, _, _),
            .decimal(let data, _),
            .binary(let data, _, _),
            .ascii(let data, _),
            .base64(let data, _):
            Array(data)
        }
    }
}

/// String 私有扩展
private extension String {
    /// 填充字符串到指定长度
    /// - Parameters:
    ///   - length: 目标长度
    ///   - character: 填充字符，默认为 "0"
    /// - Returns: 填充后的字符串
    func pad(_ length: Int, character: Character = "0") -> String {
        count < length ? String(repeatElement(character, count: length - count)) + self : self
    }
}
