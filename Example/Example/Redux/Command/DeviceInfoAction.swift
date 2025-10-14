//
//  BluetoothDeviceInfoAction.swift
//  Example
//
//  Created by Dream on 2025/9/20.
//

enum DeviceInfoAction: ActionProtocol {

    case buttons(Device?, DeviceInfoButtonsView.ButtonType)
    
    case selectedService(Service)

    case displayCharacteristicsList(Bool)

    case updateCharacteristics
    
    case receivingData
    
    case sendData

    var command: AppCommand? {

        switch self {
        case .buttons(let device, let command):
            DeviceInfoButtonsCommand(device: device, command: command)
        case .selectedService(let service):
            DeviceInfoSelectedServiceCommand(service: service)
        case .displayCharacteristicsList(let isDisplayCharacteristicsList):
            DeviceInfoDisplayCharacteristicsCommand(isDisplayCharacteristicsList)
        case .updateCharacteristics:
            DeviceInfoUpdateCharacteristicsCommand()
        case .receivingData:
            DeviceInfoCharacteristicsReceivingData()
        case .sendData:
            DeviceInfoCharacteristicsSendData()
        }

    }

}

