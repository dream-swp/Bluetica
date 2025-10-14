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

    var data = Data()

}

extension Characteristics: Identifiable {

    var id: CBUUID { characteristic.uuid }

    var uuid: String { characteristic.uuid.string }

    var status: CharacteristicState { characteristic.status }

    var properties: CBCharacteristicProperties { characteristic.properties }

    var isBroadcast: Bool { characteristic.isBroadcast }

    var isRead: Bool { characteristic.isRead }

    var isWriteWithoutResponse: Bool { characteristic.isWriteWithoutResponse }

    var isWrite: Bool { characteristic.isWrite }

    var isNotify: Bool { characteristic.isNotify }

    var isIndicate: Bool { characteristic.isIndicate }

    var isAuthenticatedSignedWrites: Bool { characteristic.isAuthenticatedSignedWrites }

    var isExtendedProperties: Bool { characteristic.isExtendedProperties }

    var isNotifyEncryptionRequired: Bool { characteristic.isNotifyEncryptionRequired }

    var isIndicateEncryptionRequired: Bool { characteristic.isIndicateEncryptionRequired }

    var decimal: String { data.convert.decimal }

    var string: String { data.convert.string }

    var hexBig: String { data.convert.hex }
    
    var hexSmall: String { data.convert.hex { (false, " ")} }

    var binary: String { data.convert.binary }

    var ascii: String { data.convert.ascii }

    var base64: String { data.convert.base64 }
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

    var propertiesString: String {
        var props: [String] = []
        if isRead { props.append("读") }
        if isWrite { props.append("写") }
        if isWriteWithoutResponse { props.append("写(无响应)") }
        if isNotify { props.append("通知") }
        if isIndicate { props.append("指示") }
        return props.joined(separator: ", ")
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
