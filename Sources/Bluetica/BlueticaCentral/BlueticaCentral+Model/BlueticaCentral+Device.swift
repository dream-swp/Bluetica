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

    public struct Device: Identifiable {
        public var id: UUID
        public let rssi: NSNumber
        public let advertisement: [String: Any]
        public var metadata: [String: Any]

        public init(id: UUID, rssi: NSNumber, advertisement: [String: Any], metadata: [String: Any]) {
            self.id = id
            self.rssi = rssi
            self.advertisement = advertisement
            self.metadata = metadata
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

    public var peripheral: CBPeripheral? {
        self.metadata[id.uuidString] as? CBPeripheral
    }

    public var name: String {
        peripheral?.name ?? "Unknown Device"
    }

    public var state: PeripheralState {
        peripheral?.state.convert ?? .unknown
    }

    public var identifier: UUID { id }

    public var isConnected: Bool {
        peripheral?.state == .connected
    }

    mutating func peripheral(_ handler: () -> (CBPeripheral) ) -> Self {
        self.metadata[id.uuidString] = peripheral
        return self
    }

}

// MARK: -
