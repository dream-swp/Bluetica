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
    
    var id: UUID {  identifier }
    let peripheral: CBPeripheral
    let rssi: NSNumber
    let advertisementData: [String: Any]
    
}

extension BluetoothDevice {
    
    
    var name: String {
        peripheral.name ?? "Unknown Device"
    }

    var identifier: UUID {
        peripheral.identifier
    }

    var state: PeripheralState {
        peripheral.state.convert
    }

    var services: [CBUUID] {
        guard let uuids = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] else { return [] }
        return uuids
    }
    
    
    var rssiInfo: String {
        "RSSI: \(rssi)"
    }
    
    var identifierInfo: String {
        "UUID: \(identifier.uuidString.prefix(8))..."
    }
    
    var isServices: Bool {
        count > 0
    }
    
    var count: Int {
        services.count
    }
    
    var serviceNames: [String] {
        services.map { "自定义服务 (\($0.uuidString.prefix(8)))" }
    }
    
    
    var isConnected: Bool {
        state == .connected
    }
}
