//
//  BlueticaConvert.swift
//  Bluetica
//
//  Created by Dream on 2025/10/11.
//


/// 转换协议
/// 用于标记支持 Bluetica 转换功能的类型
public protocol Convert {}

/// Bluetica 转换器
/// 为符合 Convert 协议的类型提供转换功能
public struct BlueticaConvert<Convert> {

    /// 转换属性
    public var convert: Convert

    /// 初始化方法
    /// - Parameter convert: 要封装的转换对象
    public init(_ convert: Convert) {
        self.convert = convert
    }
}

// MARK: - BlueticaCompatible: BlueticaConvert
extension Convert {

    /// 实例转换器属性
    /// 为实例提供转换功能的访问入口
    public var convert: BlueticaConvert<Self> {
        set {}
        get { BlueticaConvert(self) }
    }

    /// 静态转换器属性
    /// 为类型提供转换功能的访问入口
    public static var convert: BlueticaConvert<Self>.Type {
        set {}
        get { BlueticaConvert<Self>.self }
    }
}
// MARK: -

