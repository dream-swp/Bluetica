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

    public var identifier: UUID { peripheral?.identifier ?? id }

    public var isConnected: Bool {
        peripheral?.state == .connected
    }

    mutating func peripheral(_ handler: () -> (CBPeripheral)) -> Self {
        self.metadata[id.uuidString] = peripheral
        return self
    }

    public var services: [BlueticaCentral.Service] {
        peripheral?.services?.compactMap { BlueticaCentral.Service(service: $0) } ?? []
    }

    public var characteristics: [BlueticaCentral.Characteristic] {
        var result: [BlueticaCentral.Characteristic] = []
        peripheral?.services?.forEach {
            result = $0.characteristics?.compactMap { BlueticaCentral.Characteristic(characteristic: $0) } ?? []
        }
        return result
    }
    
    public var serviceCharacteristics: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] {
        var result: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] = []
        peripheral?.services?.forEach { aService in
            aService.characteristics?.forEach {
                let service = BlueticaCentral.Service(service: aService)
                let characteristic = BlueticaCentral.Characteristic(characteristic: $0)
                result.append((service: service, characteristic: characteristic))
            }
        }
        return result
    }

}

extension BlueticaCentral {

    public struct Service: Identifiable {
        public var id: UUID {
            service.peripheral?.identifier ?? UUID()
        }
        public let service: CBService
    }

}

extension BlueticaCentral {

    public struct Characteristic: Identifiable {
        public var id: UUID {
            characteristic.service?.peripheral?.identifier ?? UUID()
        }
        public let characteristic: CBCharacteristic
    }

}
// MARK: -
