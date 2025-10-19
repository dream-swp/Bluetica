//
//  BlueticaConvertValue.swift
//  Bluetica
//
//  Created by Dream on 2025/10/15.
//

import Foundation

enum BlueticaConvertValue {

    case data(Data, String.Encoding)
    case hex(Data, Bool, String)
    case decimal(Data, String)
    case binary(Data, Int, String)
    case ascii(Data, String)
    case base64(Data, Data.Base64EncodingOptions)

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

private extension String {
    func pad(_ length: Int, character: Character = "0") -> String {
        count < length ? String(repeatElement(character, count: length - count)) + self : self
    }
}
