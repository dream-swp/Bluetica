//
//  BlueticaCentral+Bridge.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//


/// 蓝牙桥接封装结构体
/// 为符合 BlueticaBridge 协议的类型提供 ba 属性访问
public struct BA<BA> {

    /// 桥接属性
    public let ba: BA

    /// 初始化方法
    /// - Parameter ba: 要封装的桥接对象
    public init(_ ba: BA) {
        self.ba = ba
    }
}

extension BlueticaBridge {

    /// 实例 ba 属性
    /// 为实例提供 BA 桥接的访问入口
    public var ba: BA<Self> {
        set {}
        get { BA(self) }
    }

    /// 静态 ba 属性
    /// 为类型提供 BA 桥接的访问入口
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

    /// 实例 central 属性
    /// 为实例提供中心桥接的访问入口
    public var central: BlueticaCentral.Central<Self> {
        set {}
        get { BlueticaCentral.Central(self) }
    }

    /// 静态 central 属性
    /// 为类型提供中心桥接的访问入口
    public static var central: BlueticaCentral.Central<Self>.Type {
        set {}
        get { BlueticaCentral.Central<Self>.self }
    }
}

// MARK: -
