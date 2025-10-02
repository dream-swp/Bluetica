//
//  ScanAction.swift
//  Example
//
//  Created by Dream on 2025/9/14.
//

enum ScanAction: ActionProtocol {

    case status
    case start
    case stop
    case scanDevice
    case selectedDevice(Device)
    case connectDevice(Device)
    case clearesDevice

    var command: AppCommand? {
        switch self {
        case .status:
            ScanStateCommand()
        case .start:
            ScanStartCommand()
        case .stop:
            ScanStopCommand()
        case .scanDevice:
            ScanDeviceCommand()
        case .selectedDevice(let device):
            ScanSelectedDeviceCommand(device: device)
        case .connectDevice(let device):
            ScanConnectDeviceCommand(device: device)
        case .clearesDevice:
            ScanClearesDeviceCommand()
        }
    }

}

