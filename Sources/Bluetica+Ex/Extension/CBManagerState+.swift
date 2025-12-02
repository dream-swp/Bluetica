//
//  CBManagerState+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

import CoreBluetooth

/// CBManagerState 扩展
/// 提供 CoreBluetooth 状态到 Bluetica 状态的转换
extension CBManagerState {
    
    /// 转换为 BlueticaStatus
    /// 将 CBManagerState 映射到自定义的蓝牙状态枚举
    public var convert: BlueticaStatus {
        switch self {
        case .unknown:
            return .unknown
        case .resetting:
            return .resetting
        case .unsupported:
            return .unsupported
        case .unauthorized:
            return .unauthorized
        case .poweredOff:
            return .poweredOff
        case .poweredOn:
            return .poweredOn
        @unknown default:
            return .unknown
        }
    }
}
