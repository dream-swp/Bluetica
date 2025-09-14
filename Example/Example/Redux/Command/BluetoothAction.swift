//
//  BluetoothAction.swift
//  Example
//
//  Created by Dream on 2025/9/14.
//


enum BluetoothAction: ActionProtocol {
    

    case status
    case start
    case stop
    case scan
    
    case info(BluetoothDevice)
    case connect
    
    var command: AppCommand? {
        switch self {
        case .status:
            return BluetoothStateCommand()
        case .start:
            return BluetoothStartCommand()
        case .stop:
            return BluetoothStopCommand()
        case .scan:
            return BluetoothScanCommand()
        case .info(let device):
            return BluetoothInfoCommand(device: device)
        case .connect:
            return nil
        }
    }
    
}
