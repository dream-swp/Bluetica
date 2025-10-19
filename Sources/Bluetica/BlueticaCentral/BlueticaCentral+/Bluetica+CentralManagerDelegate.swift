//
//  Bluetica+CentralManagerDelegate.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//

import CoreBluetooth

extension Bluetica: CBCentralManagerDelegate {

    /// 恢复中心状态时回调（如后台唤醒等场景）
    public func centralManager(_ central: CBCentralManager, willRestoreState dict: [String: Any]) {
        if verify.isBackgroundMode == false { return }
        blueticaCentral.centralHandler.restoreState?(self, (central: central, dict: dict))
    }

    /// 中心状态发生变化时回调（如蓝牙开关变化）
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        blueticaCentral.centralHandler.state?(self, central)
    }

    /// 发现外设时回调
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {

        if self.central.isEnabled == false { return }

        blueticaCentral.centralHandler.updateDiscover?(self, (central: central, peripheral: peripheral, advertisementData: advertisementData, rssi: RSSI))

        switch blueticaCentral.centralConfig.filter {
        case .none: break
        case .name:
            guard peripheral.name != nil else { return }
        case .identifier:
            guard peripheral.name != nil else { return }
            var datas = advertisementData
            datas[peripheral.identifier.uuidString] = peripheral
            let device = BlueticaCentral.Device(id: peripheral.identifier, rssi: RSSI, advertisement: advertisementData, metadata: datas)
            if blueticaCentral.peripherals.discover.contains(device) { return }
        case .custom(let value):
            if value { return }
        }

        var datas = advertisementData
        datas[peripheral.identifier.uuidString] = peripheral
        let device = BlueticaCentral.Device(id: peripheral.identifier, rssi: RSSI, advertisement: advertisementData, metadata: datas)

        blueticaCentral.peripherals.discover.append(to: device)
        blueticaCentral.centralHandler.discover?(self, (device: device, central: central))
    }

    // MARK: -

    /// 成功连接外设时回调
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        let _ = self.central.stop

        //  设置代理
        peripheral.delegate = self

        let device = blueticaCentral.peripherals.updateDiscover { peripheral }.device
        blueticaCentral.peripherals.connected.append(to: device)

        //  发现服务
        if blueticaCentral.peripheralConfig.isAutoDiscoverServices {
            peripheral.discoverServices(blueticaCentral.peripheralConfig.discoverServices)
        }

        blueticaCentral.centralHandler.connectSuccess?(self, (device: device, central: central, peripheral: peripheral))
    }

    /// 连接外设失败时回调
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {

        let device = blueticaCentral.peripherals.updateDiscover { peripheral }.device
        blueticaCentral.centralHandler.connectFailure?(self, (device: device, central: central, peripheral: peripheral, error: error))
    }

    /// 外设断开连接时回调
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        let device = blueticaCentral.peripherals.updateConnected { peripheral }.device
        blueticaCentral.centralHandler.disconnectPeripheral?(self, (device: device, central: central, peripheral: peripheral, error: error))
    }

    /// 外设断开连接（带时间戳）时回调
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: Error?) {

        let device = blueticaCentral.peripherals.updateConnected { peripheral }.device
        blueticaCentral.centralHandler.disconnectPeripheralTimestamp?(self, (device: device, central: central, peripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: error))
    }

    #if os(iOS)
        /// 连接事件发生时回调（仅 iOS）
        public func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
            blueticaCentral.centralHandler.connectionEvent?(self, (central: central, event: event, peripheral: peripheral))
        }

        /// ANCS 授权状态更新时回调（仅 iOS）
        public func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
            blueticaCentral.centralHandler.updateANCSAuthorization?(self, (central: central, peripheral: peripheral))
        }

    #endif
}

extension Bluetica: CBPeripheralDelegate {

    /// 外设名称更新时回调
    public func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        blueticaCentral.peripheralHandler.updateName?(self, peripheral)
    }

    /// 外设服务变更时回调
    public func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        blueticaCentral.peripheralHandler.modifyServices?(self, (peripheral: peripheral, invalidatedServices: invalidatedServices))
    }

    /// 外设 RSSI 更新时回调
    public func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: Error?) {
        blueticaCentral.peripheralHandler.updateRSSI?(self, (peripheral: peripheral, error: error))
    }

    /// 读取外设 RSSI 时回调
    public func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        blueticaCentral.peripheralHandler.readRSSI?(self, (peripheral: peripheral, RSSI: RSSI, error: error))
    }

    /// 发现外设服务时回调
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {

        if let error = error {
            print("didDiscoverServices >>> error = \(error.localizedDescription)")
            blueticaCentral.peripheralHandler.discoverServices?(self, (device: nil, peripheral: peripheral, error: error))
            return
        }
        if blueticaCentral.peripheralConfig.isAutoDiscoverCharacteristics {
            peripheral.services?.forEach {
                peripheral.discoverCharacteristics(blueticaCentral.peripheralConfig.discoverCharacteristics, for: $0)
            }
        }

        let device = blueticaCentral.peripherals.updateConnected { peripheral }.device
        blueticaCentral.peripheralHandler.discoverServices?(self, (device: device, peripheral: peripheral, error: error))
    }

    /// 发现包含服务时回调
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        
        let update: BlueticaCentral.Service? = nil
        var device: BlueticaCentral.Device?  = nil
        var info = (device: device, update: update, peripheral: peripheral, service: service, error: error)
        if let error = error {
            print("didDiscoverIncludedServicesFor >>> error = \(error.localizedDescription)")
            blueticaCentral.peripheralHandler.discoverIncludedServices?(self, info)
            return
        }
        device = blueticaCentral.peripherals.updateConnected { peripheral }.device
        info = (device: device, update: blueticaCentral.peripherals.service, peripheral: peripheral, service: service, error: error)
        blueticaCentral.peripheralHandler.discoverIncludedServices?(self, info)
    }

    /// 发现特征值时回调
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

        let update: BlueticaCentral.Service? = nil
        var device: BlueticaCentral.Device?  = nil
        var info = (device: device, update: update, peripheral: peripheral, service: service, error: error)
        if let error = error {
            print("didDiscoverCharacteristicsFor >>> error = \(error.localizedDescription)")
            blueticaCentral.peripheralHandler.discoverCharacteristics?(self, info)
            return
        }
        device = blueticaCentral.peripherals.updateConnected { (peripheral, service) }.device
        info = (device: device, update: blueticaCentral.peripherals.service, peripheral: peripheral, service: service, error: error)
        blueticaCentral.peripheralHandler.discoverCharacteristics?(self, info)
    }

    /// 特征值更新时回调
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        let update: BlueticaCentral.Characteristic? = nil
        var info = (update: update, peripheral: peripheral, characteristic: characteristic, error: error)
        
        guard let data = characteristic.value, error == nil else {
            blueticaCentral.peripheralHandler.updateValue?(self, nil, info)
            return
        }
        _ = blueticaCentral.peripherals.updateConnected { (peripheral, characteristic) }.device
        info = (update: blueticaCentral.peripherals.characteristic, peripheral: peripheral, characteristic: characteristic, error: error)
        
        blueticaCentral.peripheralHandler.updateValue?(self, data, info)
    }

    /// 写入特征值后回调
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        _ = blueticaCentral.peripherals.updateConnected { (peripheral, characteristic) }.device
        let info = (update: blueticaCentral.peripherals.characteristic, peripheral: peripheral, characteristic: characteristic, error: error)
        blueticaCentral.peripheralHandler.writeValue?(self, info)
        
    }

    /// 通知状态更新时回调
    public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        _ = blueticaCentral.peripherals.updateConnected { (peripheral, characteristic) }.device
        let info = (update: blueticaCentral.peripherals.characteristic, peripheral: peripheral, characteristic: characteristic, error: error)
        blueticaCentral.peripheralHandler.updateNotificationState?(self, info)
    }

    /// 发现描述符时回调
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        _ = blueticaCentral.peripherals.updateConnected { (peripheral, characteristic) }.device
        let info = (update: blueticaCentral.peripherals.characteristic, peripheral: peripheral, characteristic: characteristic, error: error)
        blueticaCentral.peripheralHandler.discoverDescriptors?(self, info)
    }

    /// 描述符值更新时回调
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        let device = blueticaCentral.peripherals.updateConnected { (peripheral, descriptor) }.device
        let info = (device: device, peripheral: peripheral, descriptor: descriptor, error: error)
        blueticaCentral.peripheralHandler.updateValueDescriptor?(self, info)
    }

    /// 写入描述符值后回调
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        let device = blueticaCentral.peripherals.updateConnected { (peripheral, descriptor) }.device
        let info = (device: device, peripheral: peripheral, descriptor: descriptor, error: error)
        blueticaCentral.peripheralHandler.writeValueDescriptor?(self, info)
    }

    /// 外设准备好无响应写入时回调
    public func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        let device = blueticaCentral.peripherals.updateConnected { peripheral }.device
        let info = (device: device, peripheral: peripheral)
        blueticaCentral.peripheralHandler.sendWriteWithoutResponse?(self, info)
    }

    /// 打开 L2CAP 信道时回调
    public func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        let device = blueticaCentral.peripherals.updateConnected { peripheral }.device
        let info = (device:device, peripheral: peripheral, channel: channel, error: error)
        blueticaCentral.peripheralHandler.openChannel?(self, info)
    }

}
