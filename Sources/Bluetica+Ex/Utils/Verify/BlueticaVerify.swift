//
//  BlueticaVerify.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//


/// 验证协议
/// 用于标记支持 Bluetica 验证功能的类型
public protocol Verify {}

// MARK: - BlueticaVerify
/// Bluetica 验证器
/// 为符合 Verify 协议的类型提供验证功能的访问入口
public struct BlueticaVerify<Verify> {

    /// 验证属性
    public let verify: Verify

    /// 初始化方法
    /// - Parameter verify: 要封装的验证对象
    public init(_ verify: Verify) {
        self.verify = verify
    }
}

// MARK: - BlueticaCompatible: BlueticaVerify
extension Verify {

    /// 实例验证属性
    /// 为实例提供验证功能的访问入口
    public var verify: BlueticaVerify<Self> {
        set {}
        get { BlueticaVerify(self) }
    }

    /// 静态验证属性
    /// 为类型提供验证功能的访问入口
    public static var verify: BlueticaVerify<Self>.Type {
        set {}
        get { BlueticaVerify<Self>.self }
    }
}
// MARK: -

/// Bluetica 类型符合 Verify 协议
extension Bluetica: Verify { }

/// String 类型符合 Verify 协议
extension String: Verify { }

/// [String] 数组类型符合 Verify 协议
extension [String]: Verify { }
