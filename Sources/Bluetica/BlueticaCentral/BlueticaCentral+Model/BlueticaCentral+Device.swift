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

    /// 蓝牙设备模型
    /// 包含设备的基本信息和广播数据
    public struct Device: Identifiable {
        /// 设备唯一标识符
        public let id: UUID
        /// 信号强度
        public let rssi: NSNumber
        /// 广播数据
        public let advertisement: [String: Any]
        /// 元数据，存储额外信息
        public var metadata: [String: Any]

        /// 初始化设备
        /// - Parameters:
        ///   - id: 设备标识符
        ///   - rssi: 信号强度
        ///   - advertisement: 广播数据
        ///   - metadata: 元数据
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

    /// 判断两个设备是否相等
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifier == rhs.identifier
    }

    /// 判断两个设备是否不相等
    public static func != (lhs: Self, rhs: Self) -> Bool {
        lhs.identifier != rhs.identifier
    }

}

extension BlueticaCentral.Device: CustomStringConvertible {
    
    /// 设备的字符串描述
    /// 包含设备名称、标识符、状态和服务信息
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

    /// 关联的蓝牙外设对象
    public var peripheral: CBPeripheral? {
        self.metadata[id.uuidString] as? CBPeripheral
    }

    /// 设备名称
    public var name: String {
        peripheral?.name ?? "Unknown Device"
    }

    /// 设备连接状态
    public var state: PeripheralState {
        peripheral?.state.convert ?? .unknown
    }

    /// 设备标识符
    public var identifier: UUID { peripheral?.identifier ?? id }

    /// 是否已连接
    public var isConnected: Bool {
        peripheral?.state == .connected
    }

    /// 设置外设对象
    /// - Parameter handler: 返回外设对象的闭包
    /// - Returns: 设备实例本身
    mutating func peripheral(_ handler: () -> (CBPeripheral)) -> Self {
        self.metadata[id.uuidString] = peripheral
        return self
    }

    /// 设备的所有服务
    public var services: [BlueticaCentral.Service] {
        peripheral?.services?.compactMap { BlueticaCentral.Service($0) } ?? []
    }

    /// 设备的所有特征
    public var characteristics: [BlueticaCentral.Characteristic] {
        var result: [BlueticaCentral.Characteristic] = []
        peripheral?.services?.forEach {
            result = $0.characteristics?.compactMap { BlueticaCentral.Characteristic($0) } ?? []
        }
        return result
    }

    /// 服务和特征的对应关系列表
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

    /// 蓝牙服务模型
    /// 封装 CBService 对象
    public struct Service {

        /// 原始服务对象
        public let service: CBService

        /// 初始化服务
        /// - Parameter service: CBService 对象
        init(_ service: CBService) { self.service = service }
    }

}

// MARK: - BlueticaCentral.Service.Extension
extension BlueticaCentral.Service: Identifiable {

    /// 唯一标识符
    public var id: UUID { UUID() }

    /// 关联的外设
    public weak var peripheral: CBPeripheral? { service.peripheral }

    /// 服务 UUID
    public var uuid: CBUUID { service.uuid }

    /// 是否为主服务
    public var isPrimary: Bool { service.isPrimary }

    /// 包含的子服务列表
    public var includedServices: [CBService] { service.includedServices ?? [] }

    /// CoreBluetooth 特征列表
    public var cbCharacteristics: [CBCharacteristic] { service.characteristics ?? [] }
    
    /// 封装后的特征列表
    public var characteristics: [BlueticaCentral.Characteristic] { cbCharacteristics.compactMap {  BlueticaCentral.Characteristic($0) } }
    
    /// 服务和特征的对应关系列表
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

    /// 蓝牙特征模型
    /// 封装 CBCharacteristic 对象
    public struct Characteristic {

        /// 原始特征对象
        public let characteristic: CBCharacteristic

        /// 初始化特征
        /// - Parameter characteristic: CBCharacteristic 对象
        init(_ characteristic: CBCharacteristic) { self.characteristic = characteristic }
    }
}

// MARK: - BlueticaCentral.Characteristic.Extension
extension BlueticaCentral.Characteristic: Identifiable {

    /// 唯一标识符
    public var id: UUID { UUID() }

    /// 特征 UUID
    public var uuid: CBUUID { characteristic.uuid }

    /// 关联的服务
    weak public var service: CBService? { characteristic.service }

    /// 特征属性
    public var properties: CBCharacteristicProperties { characteristic.properties }

    /// 特征值
    public var value: Data? { characteristic.value }

    /// 描述符列表
    public var descriptors: [CBDescriptor]? { characteristic.descriptors }

    /// 是否正在通知
    public var isNotifying: Bool { characteristic.isNotifying }
    
    /// 特征状态
    public var status: CharacteristicState { characteristic.properties.convert }
    
    /// 是否支持广播
    public var isBroadcast: Bool { properties.contains(.broadcast) }
    
    /// 是否支持读取
    public var isRead: Bool { properties.contains(.read) }
    
    /// 是否支持无响应写入
    public var isWriteWithoutResponse: Bool { properties.contains(.writeWithoutResponse) }
    
    /// 是否支持写入
    public var isWrite: Bool { properties.contains(.write) }
    
    /// 是否支持通知
    public var isNotify: Bool { properties.contains(.notify) }
    
    /// 是否支持指示
    public var isIndicate: Bool { properties.contains(.indicate) }
    
    /// 是否需要认证签名写入
    public var isAuthenticatedSignedWrites: Bool { properties.contains(.authenticatedSignedWrites) }
    
    /// 是否支持扩展属性
    public var isExtendedProperties: Bool { properties.contains(.extendedProperties) }
    
    /// 通知是否需要加密
    public var isNotifyEncryptionRequired: Bool { properties.contains(.notifyEncryptionRequired) }
    
    /// 指示是否需要加密
    public var isIndicateEncryptionRequired: Bool { properties.contains(.indicateEncryptionRequired) }

}

// MARK: -
