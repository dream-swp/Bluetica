//
//  BluetoothDeviceInfo.swift
//  Example
//
//  Created by Dream on 2025/9/10.
//

import Foundation

struct BluetoothDeviceInfo: Identifiable {
    
    var id: UUID
    var name: String
    var advertisementData: [String: Any]
}
