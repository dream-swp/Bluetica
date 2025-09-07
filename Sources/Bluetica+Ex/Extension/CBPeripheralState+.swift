//
//  CBPeripheralState+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

import CoreBluetooth

extension CBPeripheralState {

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
