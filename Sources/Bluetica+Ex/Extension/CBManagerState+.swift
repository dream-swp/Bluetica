//
//  CBManagerState+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

import CoreBluetooth

extension CBManagerState {
    
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
