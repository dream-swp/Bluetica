//
//  BlueticaCentral+Device.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.Device
extension BlueticaCentral {

    public struct Device {

        let central: CBCentralManager
        public let peripheral: CBPeripheral
        public let rssi: NSNumber
        public let advertisementData: [String: Any]

        public init(central: CBCentralManager, peripheral: CBPeripheral, rssi: NSNumber, advertisementData: [String: Any]) {
            self.central = central
            self.peripheral = peripheral
            self.rssi = rssi
            self.advertisementData = advertisementData
        }

    }
}

// MARK: - BlueticaCentral.Device.Equatable
extension BlueticaCentral.Device: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifier == rhs.identifier
    }

    public static func != (lhs: Self, rhs: Self) -> Bool {
        lhs.identifier != rhs.identifier
    }

}

// MARK: - BlueticaCentral.Device.Extension
extension BlueticaCentral.Device {
    
    public var name: String {
        peripheral.name ?? "Unknown Device"
    }

    public var state: PeripheralState {
        peripheral.state.convert
    }
    
    public var identifier: UUID {
        peripheral.identifier
    }
    
    public var isConnected: Bool {
        peripheral.state == .connected
    }
    
}

// MARK: - BlueticaCentral.Device.Extension AdvertisementData
extension BlueticaCentral.Device {

    public var localName: String {
        advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? String()
    }

    public var txPowerLevel: NSNumber? {
        advertisementData[CBAdvertisementDataTxPowerLevelKey] as? NSNumber
    }

    public var serviceUUIDs: [CBUUID] {
        advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] ?? []
    }

    public var serviceData: [CBUUID: Data] {
        advertisementData[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data] ?? [:]
    }

    public var manufacturerData: Data {
        advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data ?? Data()
    }

    public var overflowUUIDs: [CBUUID] {
        advertisementData[CBAdvertisementDataOverflowServiceUUIDsKey] as? [CBUUID] ?? []
    }
    
    public var connectable: NSNumber? {
        advertisementData[CBAdvertisementDataIsConnectable] as? NSNumber
    }
    
    public var solicitedUUIDs: [CBUUID] {
        advertisementData[CBAdvertisementDataSolicitedServiceUUIDsKey] as? [CBUUID] ?? []
    }
    
    public var isConnectable: Bool {
        guard let connectable = connectable else { return false }
        return connectable.boolValue
    }
    
}
// MARK: -
