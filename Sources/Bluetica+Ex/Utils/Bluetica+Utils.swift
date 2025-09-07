//
//  Bluetica+Utils.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaUtils: Bundle
extension BlueticaUtils where Utils == Bundle {

    var backgroundModes: [String] {
        guard let backgroundModes = Bundle.main.infoDictionary?["UIBackgroundModes"] as? [String] else {
            return []
        }
        return backgroundModes
    }

    static var defaultIdentifier: String { "com.dream.ds.bluetica" }

    var defaultIdentifier: String { Self.defaultIdentifier }

    var identifier: String { Bundle.main.bundleIdentifier ?? self.defaultIdentifier }

    static var identifier: String { Bundle.main.bundleIdentifier ?? Self.defaultIdentifier }

}



// MARK: - internal
//extension BlueticaUtils where Utils == [BlueticaCentral.Device] {
//    
//    mutating func append(_ device: BlueticaCentral.Device) {
//        if self.utils.contains(device) { return }
//        self.utils.append(device)
//    }
//}
//extension BlueticaUtils where Utils == [CBPeripheral] {
//    mutating func append(_ peripheral: CBPeripheral) {
//        if self.utils.contains(peripheral) { return }
//        self.utils.append(peripheral)
//    }
//}
//
//extension BlueticaUtils where Utils == [CBService] {
//    mutating func append(_ service: CBService) {
//        if self.utils.contains(service) { return }
//        self.utils.append(service)
//    }
//}
//
//extension BlueticaUtils where Utils == [CBCharacteristic] {
//    mutating func append(_ service: CBCharacteristic) {
//        if self.utils.contains(service) { return }
//        self.utils.append(service)
//    }
//}


