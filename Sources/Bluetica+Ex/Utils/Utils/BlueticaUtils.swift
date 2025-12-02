//
//  BlueticaUtils.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//


/// 工具协议
/// 用于标记支持 Bluetica 工具功能的类型
protocol Utils { }

// MARK: - BlueticaUtils
/// Bluetica 工具封装器
/// 为符合 Utils 协议的类型提供工具方法的访问入口
public struct BlueticaUtils<Utils> {

    /// 工具属性
    public var utils: Utils

    /// 初始化方法
    /// - Parameter utils: 要封装的工具对象
    public init(_ utils: Utils) {
        self.utils = utils
    }
}

// MARK: - BlueticaCompatible: BlueticaUtils
extension Utils {

    /// 实例工具属性
    /// 为实例提供工具方法的访问入口
    public var utils: BlueticaUtils<Self> {
        set {}
        get { BlueticaUtils(self) }
    }

    /// 静态工具属性
    /// 为类型提供工具方法的访问入口
    public static var utils: BlueticaUtils<Self>.Type {
        set {}
        get { BlueticaUtils<Self>.self }
    }
}
// MARK: -
