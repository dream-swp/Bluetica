//
//  BluetoothModel.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

struct BluetoothModel {

    var isScanning = false

    var isEnabled = false

    var status = "等待蓝牙初始化..."
    
    var isConnected = false

    var devices: [BluetoothDevice] = []
}

extension BluetoothModel {
    var message: String {
        var name = "蓝牙已关闭, 请开启蓝牙"
        if !isEnabled { return name }
        if devices.count <= 0 { return "蓝牙已开启, 等待扫描设备" }

        devices.forEach { device in
            name = "发现设备： \(device.name)"
        }
        return name
    }

    var isDevices: Bool {
        devices.count > 0
    }
}
