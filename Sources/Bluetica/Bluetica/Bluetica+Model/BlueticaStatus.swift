//
//  BlueticaStatus.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

/// 蓝牙状态枚举，表示蓝牙的各种运行状态
public enum BlueticaStatus: String, @unchecked Sendable, CaseIterable, RawRepresentable, CustomStringConvertible {

    /// 蓝牙状态未知
    case unknown
    /// 蓝牙重置中
    case resetting
    /// 设备不支持蓝牙
    case unsupported
    /// 蓝牙权限未授权
    case unauthorized
    /// 蓝牙已关闭
    case poweredOff
    /// 蓝牙已开启
    case poweredOn

    /// 状态的中文描述
    public var description: String {
        switch self {
        case .unknown:
            return "蓝牙状态未知"
        case .resetting:
            return "蓝牙重置中"
        case .unsupported:
            return "设备不支持蓝牙"
        case .unauthorized:
            return "蓝牙权限未授权"
        case .poweredOff:
            return "蓝牙已关闭"
        case .poweredOn:
            return "蓝牙已开启"
        }
    }
}


