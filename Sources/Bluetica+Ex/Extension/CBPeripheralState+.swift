//
//  CBPeripheralState+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

import CoreBluetooth

/// CBPeripheralState 扩展
/// 提供外设状态到自定义外设状态的转换
extension CBPeripheralState {

    /// 转换为 PeripheralState
    /// 将 CBPeripheralState 映射到自定义的外设状态枚举
    public var convert: PeripheralState {
        switch self {
        case .disconnected:
            return .disconnected
        case .connecting:
            return .connecting
        case .connected:
            return .connected
        case .disconnecting:
            return .disconnecting
        @unknown default:
            return .unknown
        }
    }
}
