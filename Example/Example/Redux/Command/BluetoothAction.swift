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

    case device(BluetoothDevice)
    case connect(BluetoothDevice)
    case disconnect(BluetoothDevice?, Bool)
//    case disconnectAll

    var command: AppCommand? {
        switch self {
        case .status:
            BluetoothStateCommand()
        case .start:
            BluetoothStartCommand()
        case .stop:
            BluetoothStopCommand()
        case .scan:
            BluetoothScanCommand()
        case .device(let device):
            BluetoothDeviceCommand(device: device)
        case .connect(let device):
            BluetoothConnectCommand(device: device)
        case .disconnect(let device, let isAll):
            BluetoothDisconnectCommand(device: device, isClearAll: isAll)
        }
    }

}
