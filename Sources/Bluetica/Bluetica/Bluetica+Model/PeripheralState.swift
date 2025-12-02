//
//  PeripheralState.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

/// 蓝牙外设连接状态枚举
public enum PeripheralState: String, @unchecked Sendable, CaseIterable, RawRepresentable, CustomStringConvertible {

    /// 未知状态
    case unknown
    /// 已断开连接
    case disconnected
    /// 连接中
    case connecting
    /// 已连接
    case connected
    /// 断开连接中
    case disconnecting
    
    /// 状态的中文描述
    public var description: String {
        switch self {
        case .connected:
            return "已连接"
        case .connecting:
            return "连接中..."
        case .disconnected:
            return "未连接"
        case .disconnecting:
            return "断开中..."
        case .unknown:
            return "未知状态"
        }
    }
    
}
