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
        public let id: UUID
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

extension BlueticaCentral.Device: CustomStringConvertible {
    
    
    public var description: String {
        guard let peripheral = peripheral else {
            return "没有连接的设备"
        }
        
        var text = """
        设备信息:
        名称: \(peripheral.name ?? "Unknown")
        标识符: \(peripheral.identifier)
        状态: \(peripheral.state.convert.description)
        """
        
        if let services = peripheral.services {
            text += "\n服务数量: \(services.count)"
            for (index, service) in services.enumerated() {
                text += "\n  服务 \(index + 1): \(service.uuid)"
                
                if let characteristics = service.characteristics {
                    text += " (特征: \(characteristics.count))"
                    
                    for characteristic in characteristics {
                        text += "\n    - \(characteristic.uuid)"
                        if characteristic.isNotifying {
                            text += " [通知中]"
                        }
                    }
                }
            }
        }
        
        return text
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
        peripheral?.services?.compactMap { BlueticaCentral.Service($0) } ?? []
    }

    public var characteristics: [BlueticaCentral.Characteristic] {
        var result: [BlueticaCentral.Characteristic] = []
        peripheral?.services?.forEach {
            result = $0.characteristics?.compactMap { BlueticaCentral.Characteristic($0) } ?? []
        }
        return result
    }

    public var serviceCharacteristics: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] {
        var result: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] = []
        peripheral?.services?.forEach { aService in
            aService.characteristics?.forEach {
                let service = BlueticaCentral.Service(aService)
                let characteristic = BlueticaCentral.Characteristic($0)
                result.append((service: service, characteristic: characteristic))
            }
        }
        return result
    }

}

// MARK: - BlueticaCentral.Service
extension BlueticaCentral {

    public struct Service {

        public let service: CBService

        init(_ service: CBService) { self.service = service }
    }

}

// MARK: - BlueticaCentral.Service.Extension
extension BlueticaCentral.Service: Identifiable {

    public var id: UUID { UUID() }

    public weak var peripheral: CBPeripheral? { service.peripheral }

    public var uuid: CBUUID { service.uuid }

    public var isPrimary: Bool { service.isPrimary }

    public var includedServices: [CBService] { service.includedServices ?? [] }

    public var cbCharacteristics: [CBCharacteristic] { service.characteristics ?? [] }
    
    public var characteristics: [BlueticaCentral.Characteristic] { cbCharacteristics.compactMap {  BlueticaCentral.Characteristic($0) } }
    
    public var serviceCharacteristics: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] {
        var result: [(service: BlueticaCentral.Service, characteristic: BlueticaCentral.Characteristic)] = []
        peripheral?.services?.forEach { aService in
            aService.characteristics?.forEach {
                let service = BlueticaCentral.Service(aService)
                let characteristic = BlueticaCentral.Characteristic($0)
                result.append((service: service, characteristic: characteristic))
            }
        }
        return result
    }

}

// MARK: - BlueticaCentral.Characteristic
extension BlueticaCentral {

    public struct Characteristic {

        public let characteristic: CBCharacteristic

        init(_ characteristic: CBCharacteristic) { self.characteristic = characteristic }
    }
}

// MARK: - BlueticaCentral.Characteristic.Extension
extension BlueticaCentral.Characteristic: Identifiable {

    public var id: UUID { UUID() }

    public var uuid: CBUUID { characteristic.uuid }

    weak public var service: CBService? { characteristic.service }

    public var properties: CBCharacteristicProperties { characteristic.properties }

    public var value: Data? { characteristic.value }

    public var descriptors: [CBDescriptor]? { characteristic.descriptors }

    public var isNotifying: Bool { characteristic.isNotifying }
    
    public var status: CharacteristicState { characteristic.properties.convert }
}

// MARK: -
