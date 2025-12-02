//
//  BlueticaCentral+ConfigManager.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.ManagerConfig
extension BlueticaCentral {

    /// 管理器配置类
    /// 管理蓝牙中心管理器的队列和选项配置
    public class ConfigManager: Config, @unchecked Sendable {

        /// 单例实例
        static let `default` = ConfigManager()

        /// 调度队列
        public var queue: dispatch_queue_t? = nil

        /// 管理器选项配置
        @BlueticaDefaultValue(ConfigManager.defaultOptions)
        public var options: [String: Any]?

        /// 私有初始化方法，确保单例模式
        private init() {}

    }
}

extension BlueticaCentral.ConfigManager {
    /// 默认管理器选项
    /// 包含恢复标识符配置
    static var defaultOptions: [String: Any] {
        [
            CBPeripheralManagerOptionRestoreIdentifierKey: Bundle.main.utils.identifier
        ]
    }
}

extension BlueticaCentral.ConfigManager {
    
    /// 配置调度队列
    /// - Parameter handler: 返回调度队列的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func queue(_ handler: () -> (dispatch_queue_t)) -> Self {
        self.queue = handler()
        return self
    }
    
    
    /// 配置管理器选项
    /// - Parameter handler: 返回选项字典的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func options(_ handler: () -> ([String: Any]?)) -> Self {
        self.options = handler()
        return self
    }
    
}
// MARK: -
