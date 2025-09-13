//
//  Bluetica+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/10.
//

import CoreBluetooth
import Foundation

extension [String: Any]: BlueticaBridge {}

extension BA where BA == [String: Any] {

    
    public var localName: String {
        self.ba[CBAdvertisementDataLocalNameKey] as? String ?? String()
    }
    
    public var txPowerLevel: NSNumber? {
        self.ba[CBAdvertisementDataTxPowerLevelKey] as? NSNumber
    }

    public var serviceUUIDs: [CBUUID] {
        self.ba[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] ?? []
    }

    public var serviceData: [CBUUID: Data] {
        self.ba[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data] ?? [:]
    }

    public var manufacturerData: Data {
        self.ba[CBAdvertisementDataManufacturerDataKey] as? Data ?? Data()
    }

    public var overflowUUIDs: [CBUUID] {
        self.ba[CBAdvertisementDataOverflowServiceUUIDsKey] as? [CBUUID] ?? []
    }

    public var connectable: NSNumber? {
        self.ba[CBAdvertisementDataIsConnectable] as? NSNumber
    }

    public var solicitedUUIDs: [CBUUID] {
        self.ba[CBAdvertisementDataSolicitedServiceUUIDsKey] as? [CBUUID] ?? []
    }

    public var isConnectable: Bool {
        guard let connectable = connectable else { return false }
        return connectable.boolValue
    }

}
