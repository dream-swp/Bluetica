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
        var discover: [Device] = []
        var connected: [Device] = []
        var services: [CBService] = []
        var characteristics: [CBCharacteristic] = []
    }
}
// MARK: -
