//
//  BlueticaVerify.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//


public protocol Verify {}

// MARK: - BlueticaVerify
public struct BlueticaVerify<Verify> {

    /// Prefix property
    public let verify: Verify

    /// Initialization method
    /// - Parameter verify: Verify
    public init(_ verify: Verify) {
        self.verify = verify
    }
}

// MARK: - BlueticaCompatible: BlueticaVerify
extension Verify {

//    / Instance property
    public var verify: BlueticaVerify<Self> {
        set {}
        get { BlueticaVerify(self) }
    }

    /// Static property
    public static var verify: BlueticaVerify<Self>.Type {
        set {}
        get { BlueticaVerify<Self>.self }
    }
}
// MARK: -

extension Bluetica: Verify { }

extension String: Verify { }

extension [String]: Verify { }
