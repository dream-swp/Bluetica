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
    
    case readData
    
    case updateData
    
    case sendData
    
    case notify
    
    case subscribeNotify
    
    case unsubscribeNotify

    var command: AppCommand? {

        switch self {
        case .buttons(let device, let command):
            DeviceInfoButtonsCommand(device: device, command: command)
        case .selectedService(let service):
            DeviceInfoSelectedServiceCommand(service: service)
        case .displayCharacteristicsList(let isDisplayCharacteristicsList):
            DeviceInfoDisplayCharacteristicCommand(isDisplayCharacteristicsList)
        case .updateCharacteristics:
            DeviceInfoUpdateCharacteristicCommand()
        case .readData:
            DeviceInfoCharacteristicReadData()
        case .updateData:
            DeviceInfoCharacteristicUpdateData()
        case .sendData:
            DeviceInfoCharacteristicSendData()
        case .notify:
            DeviceInfoCharacteristicNotify()
        case .subscribeNotify:
            DeviceInfoCharacteristicSubscribeNotify()
        case .unsubscribeNotify:
            DeviceInfoCharacteristicUnsubscribeNotify()
        }

    }

}
