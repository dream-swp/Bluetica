//
//  PeripheralState.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

public enum PeripheralState: String, @unchecked Sendable, CaseIterable, RawRepresentable, CustomStringConvertible {

    case unknown, disconnected, connecting, connected, disconnecting
    
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
