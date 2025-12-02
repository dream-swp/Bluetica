//
//  BlueticaCentral+ConfigCentral.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.CentralConfig
extension BlueticaCentral {

    /// 中心设备配置类
    /// 管理蓝牙中心设备的扫描、连接和过滤配置
    public class ConfigCentral: Config, @unchecked Sendable {

        /// 单例实例
        static let `default` = ConfigCentral()
        
        /// 要扫描的服务 UUID 列表
        public var services: [CBUUID]? = nil

        /// 扫描选项配置
        @BlueticaDefaultValue(ConfigCentral.defaultOptions)
        public var scanOptions: [String: Any]?

        /// 连接选项配置
        public var connectOptions: [String: Any]? = nil

        /// 扫描规则
        public var scan: BlueticaScanRule = .none

        /// 过滤规则
        public var filter: BlueticaFilterRule = .identifier
        
        /// 私有初始化方法，确保单例模式
        private init() { }
    }
}

extension BlueticaCentral.ConfigCentral {

    /// 默认扫描选项
    /// 允许重复发现同一外设
    static var defaultOptions: [String: Any] {
        [
            CBCentralManagerScanOptionAllowDuplicatesKey: true
        ]
    }
}

extension BlueticaCentral.ConfigCentral {

    /// 配置要扫描的服务列表
    /// - Parameter handler: 返回服务 UUID 数组的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func services(_ handler: () -> ([CBUUID]?)) -> Self {
        self.services = handler()
        return self

    }

    /// 配置扫描选项
    /// - Parameter handler: 返回扫描选项字典的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func scanOptions(_ handler: () -> ([String: Any]?)) -> Self {
        self.scanOptions = handler()
        return self

    }

    /// 配置连接选项
    /// - Parameter handler: 返回连接选项字典的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func connectOptions(_ handler: () -> ([String: Any]?)) -> Self {
        self.connectOptions = handler()
        return self

    }

    /// 配置扫描规则
    /// - Parameter handler: 返回扫描规则的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func scan(_ handler: () -> (BlueticaScanRule)) -> Self {
        self.scan = handler()
        return self

    }

    /// 配置过滤规则
    /// - Parameter handler: 返回过滤规则的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func filter(_ handler: () -> (BlueticaFilterRule)) -> Self {
        self.filter = handler()
        return self
    }
}

// MARK: -
