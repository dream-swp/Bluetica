//
//  BlueticaCentral+Config.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

extension BlueticaCentral {
    /// 配置协议
    /// 定义蓝牙配置的基本要求
    protocol Config {
        /// 默认配置选项
        static var defaultOptions: [String: Any] { get }
    }
}
