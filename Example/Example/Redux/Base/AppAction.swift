//
//  AppAction.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//



protocol ActionProtocol { var command: AppCommand? { get } }

enum AppAction: ActionProtocol {
    
    case bluetooth(BluetoothAction)
    case deviceInfo(BluetoothDeviceInfoAction)
    
    var command: AppCommand? {
        switch self {
        case .bluetooth(let value): value.command
        case .deviceInfo(let value): value.command
        }
    }
}



