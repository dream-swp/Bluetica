//
//  BlueticaDefaultValue.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//

// MARK: - BlinkDefaultValue
/// Bluetica 属性包装器，用于设置默认值
/// 当属性为 nil 时自动返回默认值
@propertyWrapper
public struct BlueticaDefaultValue<Element> {

    /// 默认值
    public let defaultValue: Element

    /// 实际存储值
    private var value: Element?

    /// 包装值
    /// 获取时如果为 nil 则返回默认值
    public var wrappedValue: Element? {
        get { value }
        set { value = aValue { value } }
    }
    
    /// 值处理闭包
    /// 如果值为 nil 则返回默认值，否则返回实际值
    private var aValue: (() -> (Element?)) -> Element? {
        return {
            let value = $0()
            return value == nil ? defaultValue : value
        }
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - defaultValue: 默认值
    ///   - value: 初始值，默认为 nil
    public init(_ defaultValue: Element, value: Element? = nil) {
        self.defaultValue = defaultValue
        self.value = aValue { value }
    }

}
