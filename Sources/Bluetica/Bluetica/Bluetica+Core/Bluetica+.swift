//
//  Bluetica+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/10.
//

import CoreBluetooth
import Foundation

/// 扩展字典类型以支持 BlueticaBridge 协议，用于广播数据解析
extension [String: Any]: BlueticaBridge { }


/// BA（BlueticaAdvertisement）扩展，提供蓝牙广播数据的便捷访问接口
extension BA where BA == [String: Any] {

    /// 本地设备名称
    public var localName: String {
        self.ba[CBAdvertisementDataLocalNameKey] as? String ?? String()
    }
    
    /// 发射功率等级
    public var txPowerLevel: NSNumber? {
        self.ba[CBAdvertisementDataTxPowerLevelKey] as? NSNumber
    }

    /// 服务 UUID 列表
    public var serviceUUIDs: [CBUUID] {
        self.ba[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] ?? []
    }

    /// 服务数据字典，键为 CBUUID，值为对应的数据
    public var serviceData: [CBUUID: Data] {
        self.ba[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data] ?? [:]
    }

    /// 制造商数据
    public var manufacturerData: Data {
        self.ba[CBAdvertisementDataManufacturerDataKey] as? Data ?? Data()
    }

    /// 溢出服务 UUID 列表（当广播数据包无法容纳所有服务 UUID 时使用）
    public var overflowUUIDs: [CBUUID] {
        self.ba[CBAdvertisementDataOverflowServiceUUIDsKey] as? [CBUUID] ?? []
    }

    /// 设备是否可连接（原始值）
    public var connectable: NSNumber? {
        self.ba[CBAdvertisementDataIsConnectable] as? NSNumber
    }

    /// 请求的服务 UUID 列表
    public var solicitedUUIDs: [CBUUID] {
        self.ba[CBAdvertisementDataSolicitedServiceUUIDsKey] as? [CBUUID] ?? []
    }

    /// 设备是否可连接（布尔值）
    public var isConnectable: Bool {
        guard let connectable = connectable else { return false }
        return connectable.boolValue
    }

}
