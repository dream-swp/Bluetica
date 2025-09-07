//
//  BlueticaUtils.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

// MARK: - BlueticaUtils
/// Isolation
public struct BlueticaUtils<Utils> {

    /// Prefix property
    public var utils: Utils

    /// Initialization method
    /// - Parameter utils: Utils
    public init(_ utils: Utils) {
        self.utils = utils
    }
}

// MARK: - BlueticaCompatible: BlueticaUtils
extension BlueticaBridge {

    /// Instance property
    public var utils: BlueticaUtils<Self> {
        set {}
        get { BlueticaUtils(self) }
    }

    /// Static property
    public static var utils: BlueticaUtils<Self>.Type {
        set {}
        get { BlueticaUtils<Self>.self }
    }
}
// MARK: -
