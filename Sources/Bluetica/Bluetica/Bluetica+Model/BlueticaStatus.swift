//
//  BlueticaStatus.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

public enum BlueticaStatus: String, @unchecked Sendable, CaseIterable, RawRepresentable, CustomStringConvertible {

    case unknown, resetting, unsupported, unauthorized, poweredOff, poweredOn

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


