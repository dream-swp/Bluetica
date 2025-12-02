//
//  BlueticaCentral+ConfigPeripheral.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.PeripheralConfig
extension BlueticaCentral {

    /// 外设配置类
    /// 管理蓝牙外设的服务和特征发现配置
    public class ConfigPeripheral: @unchecked Sendable {
        
        /// 单例实例
        static let `default` = ConfigPeripheral()
        /// 服务 UUID 列表
        var services: [CBUUID]? = nil
        /// 要发现的服务 UUID 列表
        public var discoverServices: [CBUUID]? = nil
        /// 要发现的特征 UUID 列表
        public var discoverCharacteristics: [CBUUID]? = nil
        /// 是否自动发现服务
        public var isAutoDiscoverServices = true
        /// 是否自动发现特征
        public var isAutoDiscoverCharacteristics = true

        /// 私有初始化方法，确保单例模式
        private init() { }
    }
}

extension BlueticaCentral.ConfigPeripheral {
    
    
    /// 配置服务 UUID 列表
    /// - Parameter handler: 返回服务 UUID 数组的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func services(_ handler: () -> ([CBUUID]?)) -> Self {
        self.services = handler()
        return self
    }
    
    
    /// 配置要发现的服务 UUID 列表
    /// - Parameter handler: 返回服务 UUID 数组的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func discoverServices(_ handler: () -> ([CBUUID]?)) -> Self {
        self.discoverServices = handler()
        return self
    }
    
    
    /// 配置要发现的特征 UUID 列表
    /// - Parameter handler: 返回特征 UUID 数组的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func discoverCharacteristics(_ handler: () -> ([CBUUID]?)) -> Self {
        self.discoverCharacteristics = handler()
        return self
    }
    
    /// 配置是否自动发现服务
    /// - Parameter handler: 返回布尔值的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func isAutoDiscoverServices(_ handler: () -> (Bool)) -> Self {
        self.isAutoDiscoverServices = handler()
        return self
    }
    
    /// 配置是否自动发现特征
    /// - Parameter handler: 返回布尔值的闭包
    /// - Returns: 配置实例本身，支持链式调用
    public func isAutoDiscoverCharacteristics(_ handler: () -> (Bool)) -> Self {
        self.isAutoDiscoverCharacteristics = handler()
        return self
    }
    
    
}

// MARK: -
