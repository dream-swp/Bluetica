//
//  BlueticaCentral+Peripherals.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth

// MARK: - BlueticaCentral.Peripherals
extension BlueticaCentral {
    struct Peripherals {
        var device: Device?
        var peripheral: CBPeripheral?
        var sysService: CBService?
        var sysCharacteristic: CBCharacteristic?
        var descriptor: CBDescriptor?
        var discover: [Device] = []
        var connected: [Device] = []
    }
}

extension BlueticaCentral.Peripherals {
    
    var service: BlueticaCentral.Service? {
        guard let sysService = sysService else { return nil }
        return BlueticaCentral.Service(sysService)
    }
    
    var characteristic: BlueticaCentral.Characteristic? {
        guard let sysCharacteristic = sysCharacteristic else { return nil }
        return BlueticaCentral.Characteristic(sysCharacteristic)
    }
}

extension BlueticaCentral.Peripherals {

    mutating func updateDiscover(_ handler: () -> (CBPeripheral)) -> Self {
        let peripheral = handler()
        let device = self.discover.device { peripheral.identifier }

        self.device = device
        self.peripheral = peripheral
        let _ = self.discover.replace { device }

        return self
    }

    mutating func updateConnected(_ handler: () -> (CBPeripheral)) -> Self {
        let peripheral = handler()
        let device = self.connected.device { peripheral.identifier }

        self.device = device
        self.peripheral = peripheral
        let _ = self.connected.replace { device }

        return self
    }
    
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
