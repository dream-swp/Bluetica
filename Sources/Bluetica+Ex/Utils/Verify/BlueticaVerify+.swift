//
//  BlueticaVerify+.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation


// MARK: - BlueticaVerify: Bluetica
/// Bluetica 验证扩展
/// 提供蓝牙相关的验证功能
extension BlueticaVerify where Verify == Bluetica {
    
    /// 是否处于后台模式
    var isBackgroundMode: Bool {
        return Bundle.main.utils.backgroundModes.count > 0
    }

    /// 检查蓝牙授权状态
    /// 打印当前蓝牙权限状态
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


/// [String] 验证扩展
/// 提供字符串数组的验证功能
extension BlueticaVerify where Verify == [String] {
    
    /// 判断所有字符串是否都是十进制数
    public var isDecimal: Bool {
        self.verify.allSatisfy { $0.verify.isDecimal }
    }
    
    /// 判断所有字符串是否都是二进制数
    public var isBinary: Bool {
        self.verify.allSatisfy { $0.verify.isBinary }
    }
}

/// String 验证扩展
/// 提供字符串的验证功能
extension BlueticaVerify where Verify == String {
    
    /// 判断字符串是否为十进制数（0-255）
    public var isDecimal: Bool {
        let trimmed = self.verify.utils.trim
        return UInt8(trimmed) != nil
    }
    
    /// 判断字符串是否为二进制数
    public var isBinary: Bool {
        let trimmed = self.verify.utils.trim
        return !trimmed.isEmpty && trimmed.allSatisfy { $0 == "0" || $0 == "1" }
    }
    
    
}

// MARK: -
