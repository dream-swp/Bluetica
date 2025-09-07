//
//  BlueticaVerify+.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation


// MARK: - BlueticaVerify: Bluetica
extension BlueticaVerify where Verify: BlueticaBridge  {
    
    var isBackgroundMode: Bool {
        return Bundle.main.utils.backgroundModes.count > 0
    }

    func isBluetoothAuthorization() {
        let status = CBManager.authorization
        switch status {
        case .allowedAlways:
            print("蓝牙权限: ✅ 始终允许（支持后台）")
        case .restricted, .denied:
            print("蓝牙权限: ❌ 受限或拒绝")
        case .notDetermined:
            print("蓝牙权限: ⏳ 未请求")
        @unknown default:
            print("蓝牙权限: ⁉️ 未知状态")
        }
    }
    
}
// MARK: -
