//
//  BluetoothService.swift
//  Example
//
//  Created by Dream on 2025/9/22.
//

import Bluetica
import CoreBluetooth
import Foundation

struct BluetoothService {

    let service: BlueticaCentral.Service
    
    var characteristicCount: Int {
        characteristic.count
    }
}

extension BluetoothService: Identifiable {

    var id: UUID { service.id }
    var uuid: CBUUID { service.uuid }
    var characteristic: [BluetoothCharacteristics] { service.characteristics.compactMap { BluetoothCharacteristics(characteristic: $0) } }
    var isPrimary: Bool { service.isPrimary }
    

}

struct BluetoothCharacteristics {
    let characteristic: BlueticaCentral.Characteristic
}
