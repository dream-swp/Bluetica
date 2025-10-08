//
//  Characteristics.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import Bluetica
import CoreBluetooth
import Foundation

struct Characteristics {

    let service: Service
    
    let characteristic: BlueticaCentral.Characteristic

}

extension Characteristics: Identifiable {


    var id: CBUUID { characteristic.uuid }

    var uuid: String { characteristic.uuid.string }

    var status: CharacteristicState { characteristic.status }

    var properties: CBCharacteristicProperties { characteristic.properties }

    public var isBroadcast: Bool { characteristic.isBroadcast }

    public var isRead: Bool { characteristic.isRead }

    public var isWriteWithoutResponse: Bool { characteristic.isWriteWithoutResponse }

    public var isWrite: Bool { characteristic.isWrite }

    public var isNotify: Bool { characteristic.isNotify }

    public var isIndicate: Bool { characteristic.isIndicate }

    public var isAuthenticatedSignedWrites: Bool { characteristic.isAuthenticatedSignedWrites }

    public var isExtendedProperties: Bool { characteristic.isExtendedProperties }

    public var isNotifyEncryptionRequired: Bool { characteristic.isNotifyEncryptionRequired }

    public var isIndicateEncryptionRequired: Bool { characteristic.isIndicateEncryptionRequired }

}

extension Characteristics {

    var name: String {
        switch uuid.uppercased() {
        case "2A19": "电池电量"
        case "2A29": "制造商名称"
        case "2A24": "型号"
        case "2A25": "序列号"
        case "2A27": "硬件版本"
        case "2A26": "固件版本"
        case "2A28": "软件版本"
        default: uuid
        }
    }
    
   
}

extension Characteristics: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public static func != (lhs: Self, rhs: Self) -> Bool {
        lhs.id != rhs.id
    }

}
