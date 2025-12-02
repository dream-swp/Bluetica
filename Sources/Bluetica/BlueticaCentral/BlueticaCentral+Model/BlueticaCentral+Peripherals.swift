//
//  BlueticaCentral+Peripherals.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth

// MARK: - BlueticaCentral.Peripherals
extension BlueticaCentral {
    /// 外设管理容器
    /// 用于存储和管理发现的设备、已连接设备及其相关的蓝牙对象
    struct Peripherals {
        /// 当前操作的设备
        var device: Device?
        /// 当前操作的外设对象
        var peripheral: CBPeripheral?
        /// 当前操作的系统服务对象
        var sysService: CBService?
        /// 当前操作的系统特征对象
        var sysCharacteristic: CBCharacteristic?
        /// 当前操作的描述符对象
        var descriptor: CBDescriptor?
        /// 已发现的设备列表
        var discover: [Device] = []
        /// 已连接的设备列表
        var connected: [Device] = []
    }
}

extension BlueticaCentral.Peripherals {
    
    /// 封装后的服务对象
    var service: BlueticaCentral.Service? {
        guard let sysService = sysService else { return nil }
        return BlueticaCentral.Service(sysService)
    }
    
    /// 封装后的特征对象
    var characteristic: BlueticaCentral.Characteristic? {
        guard let sysCharacteristic = sysCharacteristic else { return nil }
        return BlueticaCentral.Characteristic(sysCharacteristic)
    }
}

extension BlueticaCentral.Peripherals {

    /// 更新已发现设备列表
    /// - Parameter handler: 返回外设对象的闭包
    /// - Returns: 更新后的 Peripherals 实例
    mutating func updateDiscover(_ handler: () -> (CBPeripheral)) -> Self {
        let peripheral = handler()
        let device = self.discover.device { peripheral.identifier }

        self.device = device
        self.peripheral = peripheral
        let _ = self.discover.replace { device }

        return self
    }

    /// 更新已连接设备列表（仅外设）
    /// - Parameter handler: 返回外设对象的闭包
    /// - Returns: 更新后的 Peripherals 实例
    mutating func updateConnected(_ handler: () -> (CBPeripheral)) -> Self {
        let peripheral = handler()
        let device = self.connected.device { peripheral.identifier }

        self.device = device
        self.peripheral = peripheral
        let _ = self.connected.replace { device }

        return self
    }
    
    /// 更新已连接设备列表（外设和服务）
    /// - Parameter handler: 返回外设和服务对象的闭包
    /// - Returns: 更新后的 Peripherals 实例
    mutating func updateConnected(_ handler: () -> (peripheral: CBPeripheral, service: CBService)) -> Self {
        let peripheral = handler().peripheral
        let service = handler().service
        let device = self.connected.device { peripheral.identifier }
        self.device = device
        self.peripheral = peripheral
        self.sysService = service
        let _ = self.connected.replace { device }

        return self
    }

    /// 更新已连接设备列表（外设和特征）
    /// - Parameter handler: 返回外设和特征对象的闭包
    /// - Returns: 更新后的 Peripherals 实例
    mutating func updateConnected(_ handler: () -> (peripheral: CBPeripheral, characteristic: CBCharacteristic)) -> Self {
        let peripheral = handler().peripheral
        let characteristic = handler().characteristic
        let device = self.connected.device { peripheral.identifier }
        self.device = device
        self.peripheral = peripheral
        self.sysCharacteristic = characteristic
        let _ = self.connected.replace { device }

        return self
    }
    
    /// 更新已连接设备列表（外设和描述符）
    /// - Parameter handler: 返回外设和描述符对象的闭包
    /// - Returns: 更新后的 Peripherals 实例
    mutating func updateConnected(_ handler: () -> (peripheral: CBPeripheral, descriptor: CBDescriptor)) -> Self {
        let peripheral = handler().peripheral
        let descriptor = handler().descriptor
        let device = self.connected.device { peripheral.identifier }
        self.device = device
        self.peripheral = peripheral
        self.descriptor = descriptor
        let _ = self.connected.replace { device }

        return self
    }
}
// MARK: -
