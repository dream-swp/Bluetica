//
//  Bluetica+Central+Core.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//

import CoreBluetooth

/// BlueticaCentral.Central 的扩展，提供配置管理器的能力
extension BlueticaCentral.Central where Central == Bluetica {

    /// 配置 BlueticaCentral 的管理器参数
    /// - Parameter manager: 返回 ConfigManager 的闭包
    /// - Returns: 返回自身以便链式调用
    public var manager: (() -> BlueticaCentral.ConfigManager) -> Self {
        return { [weak central] in
            central?.blueticaCentral.managerConfig = $0()
            return Bluetica.default.central
        }
    }

}

/// BlueticaCentral.Central 的扩展，提供中心设备的核心操作能力
extension BlueticaCentral.Central where Central == Bluetica {

    /// 配置中心参数
    /// - Parameter handler: 配置闭包，传入并返回 ConfigCentral
    /// - Returns: 返回自身以便链式调用
    public var config: (_ handler: (BlueticaCentral.ConfigCentral) -> BlueticaCentral.ConfigCentral) -> Self {
        return {
            let config = $0(central.blueticaCentral.centralConfig)
            central.blueticaCentral.centralConfig = config
            return Bluetica.default.central
        }
    }

    /// 配置中心参数（函数式调用）
    /// - Parameter handler: 配置闭包，传入并返回 ConfigCentral
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func config(_ handler: (BlueticaCentral.ConfigCentral) -> (BlueticaCentral.ConfigCentral)) -> Self {
        //        let config = handler(central.blueticaCentral.centralConfig)
        //        central.blueticaCentral.centralConfig = config
        return config(handler)
    }

    /// 当前中心是否已启用（蓝牙是否已打开）
    public var isEnabled: Bool {
        return status == .poweredOn
    }

    /// 当前中心的蓝牙状态
    public var status: BlueticaStatus {
        central.centralManager.state.convert
    }

    /// 当前是否正在扫描设备
    public var isScanning: Bool { central.blueticaCentral.isScanning }

    /// 开始扫描设备
    public var start: Void { central.startScan() }

    /// 停止扫描设备
    public var stop: Bluetica { stop() }

    /// 停止扫描（可选是否移除设备）
    /// - Parameter isRemove: 是否移除设备，默认 false
    /// - Returns: 返回 Bluetica 实例
    @discardableResult
    public func stop(_ isRemove: Bool = false) -> Bluetica { central.stopScan() }

    /// 连接指定的外设（闭包方式）
    /// - Parameter peripheral: 返回 CBPeripheral 的闭包
    /// - Returns: 返回自身以便链式调用
    public var connect: (() -> CBPeripheral?) -> Self {
        return { [weak central] in
            let peripheral = $0()
            central?.central.connect(peripheral)
            return Bluetica.default.central
        }
    }

    /// 连接指定的外设
    /// - Parameter peripheral: 目标外设
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func connect(_ peripheral: CBPeripheral?) -> Self {

        if let peripheral = peripheral, peripheral.state.convert != .connected {
            central.centralManager.connect(peripheral, options: central.blueticaCentral.centralConfig.connectOptions)
        }

        return Bluetica.default.central
    }

    /// 断开指定外设连接（闭包方式）
    /// - Parameter peripheral: 返回 CBPeripheral 的闭包
    /// - Returns: 返回自身以便链式调用
    public var cancel: (() -> CBPeripheral?) -> Self {
        return { [weak central] in
            let peripheral = $0()
            central?.central.cancel(peripheral)
            return Bluetica.default.central
        }
    }

    /// 断开指定外设连接
    /// - Parameter peripheral: 目标外设
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func cancel(_ peripheral: CBPeripheral?) -> Self {
        if let peripheral = peripheral, peripheral.state.convert == .connected {
            central.centralManager.cancelPeripheralConnection(peripheral)
        }

        return Bluetica.default.central
    }

    /// 断开所有已连接的外设
    public var cancels: Self {
        central.blueticaCentral.peripherals.connected.forEach { device in
            let _ = cancel { device.peripheral }
        }
        return Bluetica.default.central
    }

    /// 断开指定外设数组的连接
    /// - Parameter peripherals: 外设数组
    /// - Returns: 返回自身以便链式调用
    public func cancels(_ peripherals: [CBPeripheral]) -> Self {
        peripherals.forEach { peripheral in
            let _ = cancel { peripheral }
        }
        return Bluetica.default.central
    }

    /// 是否已清空已发现的设备
    public var isClearDevice: Bool {
        central.blueticaCentral.peripherals.discover.count <= 0
    }

    public var clearDevice: Self {
        let _ = cancels
        let _ = central.blueticaCentral.peripherals.discover.removeAll()
        return self
    }

}

/// BlueticaCentral.Central 的扩展，提供外设相关的配置和属性
extension BlueticaCentral.Central where Central == Bluetica {

    /// 配置外设参数
    /// - Parameter peripheral: 返回 ConfigPeripheral 的闭包
    /// - Returns: 返回自身以便链式调用
    public var peripheral: (() -> BlueticaCentral.ConfigPeripheral) -> Self {
        return { [weak central] in
            central?.blueticaCentral.peripheralConfig = $0()
            return Bluetica.default.central
        }
    }
    
    
    public func refreshServices(_ device: BlueticaCentral.Device) -> Self {
        guard let peripheral = central.blueticaCentral.peripherals.peripheral, peripheral.state == .connected else {
            return Bluetica.default.central
        }
        peripheral.discoverServices(self.central.blueticaCentral.peripheralConfig.discoverServices)
        return Bluetica.default.central
    }
    
    public func refreshServices(_ handler: () -> (BlueticaCentral.Device)) -> Self {
        refreshServices(handler())
    }
    
    public var refreshServices: (() -> BlueticaCentral.Device) -> Self {
        return {
            refreshServices($0())
        }
    }
    
    
    public func refreshCharacteristics(_ device: BlueticaCentral.Device) -> Self {
        guard let peripheral = central.blueticaCentral.peripherals.peripheral, peripheral.state == .connected else {
            return Bluetica.default.central
        }
        
        peripheral.services?.compactMap {
            peripheral.discoverCharacteristics(central.blueticaCentral.peripheralConfig.discoverCharacteristics, for: $0)
        }
        return Bluetica.default.central
    }
    
    public func refreshCharacteristics(_ handler: () -> (BlueticaCentral.Device)) -> Self {
        refreshCharacteristics(handler())
    }
    
    public var refreshCharacteristics: (() -> BlueticaCentral.Device) -> Self {
        return {
            refreshCharacteristics($0())
        }
    }
    
}

extension BlueticaCentral.Central where Central == Bluetica {
    
    // MARK: - Read Value Data
    @discardableResult
    public func readData(_ characteristic: CBCharacteristic) -> Self {
        guard let peripheral = central.blueticaCentral.peripherals.peripheral, peripheral.state == .connected else {
            return Bluetica.default.central
        }
        peripheral.readValue(for: characteristic)
        return Bluetica.default.central
    }

    public var readData: (() -> BlueticaCentral.Characteristic) -> Self {
        return {
            self.readData($0().characteristic)
        }
    }

    @discardableResult
    public func readData(_ handler: () -> BlueticaCentral.Characteristic) -> Self {
        self.readData(handler)
    }

    // MARK: - Notify Value Data
    @discardableResult
    public func notifyData(_ enabled: Bool, for characteristic: CBCharacteristic) -> Self {
        guard let peripheral = central.blueticaCentral.peripherals.peripheral, peripheral.state == .connected else {
            return Bluetica.default.central
        }
        peripheral.setNotifyValue(enabled, for: characteristic)
        return Bluetica.default.central
    }

    public var notifyData: (() -> (enabled: Bool, characteristic: BlueticaCentral.Characteristic)) -> Self {
        return {
            self.notifyData($0().enabled, for: $0().characteristic.characteristic)
        }
    }

    @discardableResult
    public func notifyData(_ handler: () -> (enabled: Bool, characteristic: BlueticaCentral.Characteristic)) -> Self {
        self.notifyData(handler)
    }
    
    @discardableResult
    public func subscribeNotify(_ handler: () -> BlueticaCentral.Characteristic) -> Self {
        subscribeNotify(handler)
    }
    
    public var subscribeNotify: (() -> BlueticaCentral.Characteristic) -> Self {
        return { characteristic in
            notifyData { (enabled: true, characteristic: characteristic()) }
        }
    }
    
    public func unSubscribeNotify(_ handler: () -> BlueticaCentral.Characteristic) -> Self {
        unSubscribeNotify(handler)
    }
    
    public var unSubscribeNotify: (() -> BlueticaCentral.Characteristic) -> Self {
        return { characteristic in
            notifyData { (enabled: false, characteristic: characteristic()) }
        }
    }
    

    // MARK: - Write Value Data
    public var writeDataResponse: (() -> (data: Data, characteristic: BlueticaCentral.Characteristic)) -> Self {
        return {
            self.writeValue($0().data, for: $0().characteristic.characteristic)
        }
    }

    @discardableResult
    public func writeDataResponse(_ handler: () -> (data: Data, characteristic: BlueticaCentral.Characteristic)) -> Self {
        self.writeDataResponse(handler)
    }

    public var writeDataWithoutResponse: (() -> (data: Data, characteristic: BlueticaCentral.Characteristic)) -> Self {
        return {
            self.writeValue($0().data, for: $0().characteristic.characteristic, type: .withoutResponse)
        }
    }

    @discardableResult
    public func writeDataWithoutResponse(_ handler: () -> (data: Data, characteristic: BlueticaCentral.Characteristic)) -> Self {
        self.writeDataWithoutResponse(handler)
    }
    
    @discardableResult
    public func writeValue(_ data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType = .withResponse) -> Self {
        guard let peripheral = central.blueticaCentral.peripherals.peripheral, peripheral.state == .connected else {
            return Bluetica.default.central
        }
        peripheral.writeValue(data, for: characteristic, type: type)
        return Bluetica.default.central
    }
    
    @discardableResult
    public func writeValue(_ data: Data, for descriptor: CBDescriptor) -> Self {
        guard let peripheral = central.blueticaCentral.peripherals.peripheral, peripheral.state == .connected else {
            return Bluetica.default.central
        }
        peripheral.writeValue(data, for: descriptor)
        return Bluetica.default.central
    }
    
    // TODO: - 
//    open func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: CBService)
//    open func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int
//    open func discoverDescriptors(for characteristic: CBCharacteristic)
//    open func openL2CAPChannel(_ PSM: CBL2CAPPSM)

}
