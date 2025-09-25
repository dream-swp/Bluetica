//
//  BluetoothDeviceInfoAction.swift
//  Example
//
//  Created by Dream on 2025/9/20.
//


enum BluetoothDeviceInfoAction: ActionProtocol {

    case deviceInfoButtons(BluetoothDevice?, BluetoothDeviceInfoButtons.ButtonType)
    case autoDiscoverServices
    
    case deviceInfoService(BluetoothService)

    var command: AppCommand? {
        
        switch self {
        case .deviceInfoButtons(let device, let command):
            BluetoothDeviceInfoButtonsCommand(device: device, command: command)
        case .autoDiscoverServices:
            BluetoothDeviceAutoDiscoverServices()
        case .deviceInfoService(let service):
            BluetoothDeviceInfoServiceCommand(service: service)
        }
 
    }

}


