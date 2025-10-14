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
}
