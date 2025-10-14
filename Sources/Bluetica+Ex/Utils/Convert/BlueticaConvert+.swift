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
        Array(self.convert)
    }

    public var decimal: String {
        self.decimal()
    }

    public func decimal(_ handler: () -> String = { ", " }) -> String {
        self.convert.map { String($0) }.joined(separator: handler())
    }

    public var string: String {
        self.string { .utf8 }
    }

    public func string(_ handler: () -> String.Encoding = { .utf8 }) -> String {
        String(data: self.convert, encoding: handler()) ?? ""
    }

    public var hex: String {
        self.hex { (isUppercased: true, separator: " ") }
    }

    public func hex(_ handler: () -> (isUppercased: Bool, separator: String) = { (true, " ") }) -> String {
        let result = handler()
        let format = result.isUppercased ? "%02X" : "%02x"
        return self.convert.map { String(format: format, $0) }.joined(separator: result.separator)
    }

    public var binary: String {
        self.binary()
    }

    public func binary(_ handler: () -> (pad: Int, separator: String) = { (8, " ") }) -> String {
        self.convert.map { String($0, radix: 2).pad(handler().pad) }.joined(separator: handler().separator)
    }

    public var ascii: String {
        self.ascii()
    }

    public func ascii(_ handler: () -> String = { "*" }) -> String {
        self.convert.map { (32...126).contains($0) ? String(Character(UnicodeScalar($0))) : handler() }.joined()
    }

    public var base64: String {
        self.convert.base64EncodedString()
    }
}
 
extension BlueticaConvert where Convert == Data? {

    public var decimals: [UInt8] {
        guard let data = self.convert else { return [] }
        return Array(data)
    }

    public var decimal: String {
        self.convert?.map { String($0) }.joined(separator: ",") ?? ""
    }

    public var string: String { self.string { .utf8 } ?? "" }

    public func string(_ handler: () -> String.Encoding = { .utf8 }) -> String {
        guard let data = self.convert, let string = String(data: data, encoding: handler()) else { return "" }
        return string
    }

    public var hex: String {
        self.hex()
    }

    public func hex(_ handler: () -> (isUppercased: Bool, separator: String) = { (true, " ") }) -> String {
        guard let data = self.convert else { return "" }
        let result = handler()
        let format = result.isUppercased ? "%02X" : "%02x"
        return data.map { String(format: format, $0) }.joined(separator: result.separator)
    }

    public var binary: String {
        self.binary()
    }

    public func binary(_ handler: () -> (pad: Int, separator: String) = { (8, " ") }) -> String {
        self.convert?.map { String($0, radix: 2).pad(handler().pad) }.joined(separator: handler().separator) ?? ""
    }

    public var ascii: String {
        self.ascii()
    }

    public func ascii(_ handler: () -> String = { "*" }) -> String {
        self.convert?.map { (32...126).contains($0) ? String(Character(UnicodeScalar($0))) : handler() }.joined() ?? ""
    }

    public var base64: String {
        self.convert?.base64EncodedString() ?? ""
    }
}

extension String {

    fileprivate func pad(_ length: Int, character: Character = "0") -> String {
        count < length ? String(repeatElement(character, count: length - count)) + self : self
    }
}

// MARK: - BlueticaConvert: String
extension String: Convert {}

extension BlueticaConvert where Convert == String {

    public func data(_ handler: () -> String.Encoding) -> Data {
        return BlueticaConvertData.data(self.convert, handler()).data
    }

    public var data: Data {
        data { .utf8 }
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
        BlueticaConvertData.base64(self.convert, []).data
    }
}

// MARK: -
