//
//  BlueticaCentral+Bridge.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//


/// Item
public struct BA<BA> {

    /// Prefix property
    public let ba: BA

    /// Initialization method
    /// - Parameter ba: Item
    public init(_ ba: BA) {
        self.ba = ba
    }
}

extension BlueticaBridge {

    /// Instance property
    public var ba: BA<Self> {
        set {}
        get { BA(self) }
    }

    /// Static property
    public static var ba: BA<Self>.Type {
        set {}
        get { BA<Self>.self }
    }
}


// MARK: - BlueticaCentral.Manager
extension BlueticaCentral {
    /// 中心桥接结构体，包装泛型 central
    public struct Central<Central> {
        /// 被桥接的 central 实例
        public let central: Central

        /// 初始化
        /// - Parameter central: 需要桥接的 central
        public init(_ central: Central) {
            self.central = central
        }
    }
}

extension BlueticaBridge {

    /// 实例级 central 桥接属性
    public var central: BlueticaCentral.Central<Self> {
        set {}
        get { BlueticaCentral.Central(self) }
    }

    /// 类型级 central 桥接属性
    public static var central: BlueticaCentral.Central<Self>.Type {
        set {}
        get { BlueticaCentral.Central<Self>.self }
    }
}

// MARK: -
