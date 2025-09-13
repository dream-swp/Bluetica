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
    /// 管理器桥接结构体，包装泛型 manager
    public struct Manager<Manager> {
        /// 被桥接的 manager 实例
        public let manager: Manager

        /// 初始化
        /// - Parameter manager: 需要桥接的 manager
        public init(_ manager: Manager) {
            self.manager = manager
        }
    }
}

extension BlueticaBridge {

    /// 实例级 manager 桥接属性
    public var manager: BlueticaCentral.Manager<Self> {
        set {}
        get { BlueticaCentral.Manager(self) }
    }

    /// 类型级 manager 桥接属性
    public static var manager: BlueticaCentral.Manager<Self>.Type {
        set {}
        get { BlueticaCentral.Manager<Self>.self }
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


// MARK: - BlueticaCentral.Peripheral

extension BlueticaCentral {
    /// 外设桥接结构体，包装泛型 peripheral
    public struct Peripheral<Peripheral> {
        /// 被桥接的 peripheral 实例
        public let peripheral: Peripheral

        /// 初始化
        /// - Parameter peripheral: 需要桥接的 peripheral
        public init(_ peripheral: Peripheral) {
            self.peripheral = peripheral
        }
    }
}


extension BlueticaBridge {

    /// 实例级 peripheral 桥接属性
    public var peripheral: BlueticaCentral.Peripheral<Self> {
        set {}
        get { BlueticaCentral.Peripheral(self) }
    }

    /// 类型级 peripheral 桥接属性
    public static var peripheral: BlueticaCentral.Peripheral<Self>.Type {
        set {}
        get { BlueticaCentral.Peripheral<Self>.self }
    }
}

// MARK: -
