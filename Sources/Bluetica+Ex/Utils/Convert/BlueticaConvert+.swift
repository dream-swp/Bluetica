//
//  BlueticaConver+Data.swift
//  Bluetica
//
//  Created by Dream on 2025/10/11.
//

import Foundation

// MARK: - BlueticaConvert: Data

/// Data 类型符合 Convert 协议
extension Data: Convert {}

/// Data 转换器扩展
/// 提供 Data 到各种格式的转换方法
extension BlueticaConvert where Convert == Data {

    /// 转换为十进制字节数组
    public var decimals: [UInt8] {
        BlueticaConvertValue.decimal(self.convert, ", ").bytes
    }

    /// 转换为十进制字符串（默认逗号分隔）
    public var decimal: String {
        self.decimal()
    }

    /// 转换为十进制字符串
    /// - Parameter handler: 返回分隔符的闭包
    /// - Returns: 十进制字符串
    public func decimal(_ handler: () -> String = { ", " }) -> String {
        BlueticaConvertValue.decimal(self.convert, handler()).value
    }

    /// 转换为字符串（默认 UTF-8 编码）
    public var value: String {
        self.value { .utf8 }
    }

    /// 转换为字符串
    /// - Parameter handler: 返回字符串编码的闭包
    /// - Returns: 转换后的字符串
    public func value(_ handler: () -> String.Encoding = { .utf8 }) -> String {
        BlueticaConvertValue.data(self.convert, handler()).value
    }

    /// 转换为十六进制字符串（默认大写，空格分隔）
    public var hex: String {
        self.hex { (isUppercased: true, separator: " ") }
    }

    /// 转换为十六进制字符串
    /// - Parameter handler: 返回是否大写和分隔符的闭包
    /// - Returns: 十六进制字符串
    public func hex(_ handler: () -> (isUppercased: Bool, separator: String) = { (true, " ") }) -> String {
        BlueticaConvertValue.hex(self.convert, handler().isUppercased, handler().separator).value
    }

    /// 转换为二进制字符串（默认8位填充，空格分隔）
    public var binary: String {
        self.binary()
    }

    /// 转换为二进制字符串
    /// - Parameter handler: 返回填充位数和分隔符的闭包
    /// - Returns: 二进制字符串
    public func binary(_ handler: () -> (pad: Int, separator: String) = { (8, " ") }) -> String {
        BlueticaConvertValue.binary(self.convert, handler().pad, handler().separator).value
    }

    /// 转换为 ASCII 字符串（默认不可见字符用 * 替换）
    public var ascii: String {
        self.ascii()
    }

    /// 转换为 ASCII 字符串
    /// - Parameter handler: 返回不可见字符替换符的闭包
    /// - Returns: ASCII 字符串
    public func ascii(_ handler: () -> String = { "*" }) -> String {
        BlueticaConvertValue.ascii(self.convert, handler()).value
    }

    /// 转换为 Base64 字符串（默认选项）
    public var base64: String {
        self.base64()
    }

    /// 转换为 Base64 字符串
    /// - Parameter handler: 返回 Base64 编码选项的闭包
    /// - Returns: Base64 字符串
    public func base64(_ handler: () -> Data.Base64EncodingOptions = { [] }) -> String {
        BlueticaConvertValue.base64(self.convert, handler()).value
    }
}

// MARK: - BlueticaConvert: String
/// String 类型符合 Convert 协议
extension String: Convert {}

/// String 转换器扩展
/// 提供 String 到 Data 和各种格式的转换方法
extension BlueticaConvert where Convert == String {

    /// 转换为 Data（默认 UTF-8 编码）
    public var data: Data {
        data { .utf8 }
    }

    /// 转换为 Data
    /// - Parameter handler: 返回字符串编码的闭包
    /// - Returns: Data 对象
    public func data(_ handler: () -> String.Encoding) -> Data {
        BlueticaConvertData.data(self.convert, handler()).data
    }

    /// 从十六进制字符串转换为 Data
    public var hex: Data {
        BlueticaConvertData.hex(self.convert).data
    }

    /// 十进制字符串原始数组
    public var decimalsOriginal: [String] {
        BlueticaConvertData.decimal(self.convert).original
    }

    /// 从十进制字符串转换为字节数组
    public var decimals: [UInt8] {
        BlueticaConvertData.decimal(self.convert).decimals
    }

    /// 从十进制字符串转换为 Data
    public var decimal: Data {
        BlueticaConvertData.decimal(self.convert).data
    }

    /// 从二进制字符串转换为字节数组
    public var binarys: [UInt8] {
        BlueticaConvertData.binary(self.convert).binarys
    }

    /// 从二进制字符串转换为 Data
    public var binary: Data {
        BlueticaConvertData.binary(self.convert).data
    }

    /// 从 Base64 字符串转换为 Data（默认选项）
    public var base64: Data {
        base64 { [] }
    }

    /// 从 Base64 字符串转换为 Data
    /// - Parameter handler: 返回 Base64 解码选项的闭包
    /// - Returns: Data 对象
    public func base64(_ handler: () -> Data.Base64DecodingOptions) -> Data {
        BlueticaConvertData.base64(self.convert, handler()).data
    }
}

// MARK: -
