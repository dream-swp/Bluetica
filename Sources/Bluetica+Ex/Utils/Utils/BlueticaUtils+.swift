//
//  Bluetica+Utils.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaUtils: Bundle
/// Bundle 类型符合 Utils 协议
extension Bundle: Utils {}

/// Bundle 工具扩展
/// 提供 Bundle 的实用工具方法
extension BlueticaUtils where Utils == Bundle {

    /// 获取后台模式列表
    var backgroundModes: [String] {
        guard let backgroundModes = Bundle.main.infoDictionary?["UIBackgroundModes"] as? [String] else {
            return []
        }
        return backgroundModes
    }

    /// 默认标识符（静态）
    static var defaultIdentifier: String { "com.dream.ds.bluetica" }

    /// 默认标识符（实例）
    var defaultIdentifier: String { Self.defaultIdentifier }

    /// 应用程序标识符（实例）
    var identifier: String { Bundle.main.bundleIdentifier ?? self.defaultIdentifier }

    /// 应用程序标识符（静态）
    static var identifier: String { Bundle.main.bundleIdentifier ?? Self.defaultIdentifier }

}

// MARK: - BlueticaUtils: String
/// String 类型符合 Utils 协议
extension String: Utils { }

/// String 工具扩展
/// 提供 String 的实用工具方法
extension BlueticaUtils where Utils == String {
    
    /// 移除字符串首尾空白字符和换行符
    var trim: String {
        self.utils.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: -
