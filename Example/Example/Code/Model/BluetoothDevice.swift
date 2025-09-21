//
//  BluetoothDevice.swift
//  Example
//
//  Created by Dream on 2025/9/3.
//

import Foundation
import CoreBluetooth
import Bluetica

struct BluetoothDevice: Identifiable {
    
    var device: BlueticaCentral.Device

    var id: UUID { device.identifier }
    
    var name: String { device.name }
    
    var rssi: NSNumber { device.rssi }
    
    var rssiInfo: String { "RSSI: \(device.rssi)" }
    
    var rssiValue: Int { rssi.intValue }
    
    var peripheral: CBPeripheral? { device.peripheral }
    
    var state: PeripheralState { device.state }
    
    var isConnected: Bool { state == .connected }

    var identifierInfo: String { "UUID: \(device.identifier.uuidString.prefix(8))..." }
    
    var serviceUUIDs: [CBUUID] {  device.metadata.ba.serviceUUIDs }
    
    var serviceNames: [String] {  serviceUUIDs.map { "自定义服务 (\($0.uuidString.prefix(8)))" } }
    
    var isServices: Bool { serviceUUIDs.count > 0 }
    
    var advertisement: [String: Any] { device.advertisement }
    
    var services: [BlueticaCentral.Service] { device.services }
    
    var characteristics: [BlueticaCentral.Characteristic] { device.characteristics }
    
    var serviceCharacteristics: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] { device.serviceCharacteristics }
    
}

extension BluetoothDevice: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    static func != (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}


