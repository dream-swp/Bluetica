//
//  BlueticaConvert.swift
//  Bluetica
//
//  Created by Dream on 2025/10/11.
//


public protocol Convert {}

public struct BlueticaConvert<Convert> {

    /// Prefix property
    public var convert: Convert

    /// Initialization method
    /// - Parameter convert: Utils
    public init(_ convert: Convert) {
        self.convert = convert
    }
}

// MARK: - BlueticaCompatible: BlueticaConvert
extension Convert {

    /// Instance property
    public var convert: BlueticaConvert<Self> {
        set {}
        get { BlueticaConvert(self) }
    }

    /// Static property
    public static var convert: BlueticaConvert<Self>.Type {
        set {}
        get { BlueticaConvert<Self>.self }
    }
}
// MARK: -

