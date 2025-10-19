//
//  BlueticaConver+Data.swift
//  Bluetica
//
//  Created by Dream on 2025/10/11.
//

import Foundation

// MARK: - BlueticaConvert: Data

extension Data: Convert {}

extension BlueticaConvert where Convert == Data {

    public var decimals: [UInt8] {
        BlueticaConvertValue.decimal(self.convert, ", ").bytes
    }

    public var decimal: String {
        self.decimal()
    }

    public func decimal(_ handler: () -> String = { ", " }) -> String {
        BlueticaConvertValue.decimal(self.convert, handler()).value
    }

    public var value: String {
        self.value { .utf8 }
    }

    public func value(_ handler: () -> String.Encoding = { .utf8 }) -> String {
        BlueticaConvertValue.data(self.convert, handler()).value
    }

    public var hex: String {
        self.hex { (isUppercased: true, separator: " ") }
    }

    public func hex(_ handler: () -> (isUppercased: Bool, separator: String) = { (true, " ") }) -> String {
        BlueticaConvertValue.hex(self.convert, handler().isUppercased, handler().separator).value
    }

    public var binary: String {
        self.binary()
    }

    public func binary(_ handler: () -> (pad: Int, separator: String) = { (8, " ") }) -> String {
        BlueticaConvertValue.binary(self.convert, handler().pad, handler().separator).value
    }

    public var ascii: String {
        self.ascii()
    }

    public func ascii(_ handler: () -> String = { "*" }) -> String {
        BlueticaConvertValue.ascii(self.convert, handler()).value
    }

    public var base64: String {
        self.base64()
    }

    public func base64(_ handler: () -> Data.Base64EncodingOptions = { [] }) -> String {
        BlueticaConvertValue.base64(self.convert, handler()).value
    }
}

// MARK: - BlueticaConvert: String
extension String: Convert {}

extension BlueticaConvert where Convert == String {

    public var data: Data {
        data { .utf8 }
    }

    public func data(_ handler: () -> String.Encoding) -> Data {
        return BlueticaConvertData.data(self.convert, handler()).data
    }

    public var hex: Data {
        BlueticaConvertData.hex(self.convert).data
    }

    public var decimalsOriginal: [String] {
        BlueticaConvertData.decimal(self.convert).original
    }

    public var decimals: [UInt8] {
        BlueticaConvertData.decimal(self.convert).decimals
    }

    public var decimal: Data {
        BlueticaConvertData.decimal(self.convert).data
    }

    public var binarys: [UInt8] {
        BlueticaConvertData.binary(self.convert).binarys
    }

    public var binary: Data {
        BlueticaConvertData.binary(self.convert).data
    }

    public var base64: Data {
        base64 { [] }
    }

    public func base64(_ handler: () -> Data.Base64DecodingOptions) -> Data {
        BlueticaConvertData.base64(self.convert, handler()).data
    }
}

// MARK: -
