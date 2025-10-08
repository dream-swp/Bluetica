//
//  BluetoothDeviceInfoCommand.swift
//  Example
//
//  Created by Dream on 2025/9/20.
//

import Bluetica
import CoreBluetooth
import Foundation

struct DeviceInfoButtonsCommand: AppCommand {

    let device: Device?
    let command: DeviceInfoButtonsView.ButtonType

    func execute(_ store: AppStore, action: AppAction) {

        switch command {
        case .none:
            break
        case .disconnect:
            let _ = store.appState.bluetica.central.cancel { device?.peripheral }
        case .subscribe:
            break
        case .refresh:
            break
        case .characteristic:
            break
        }
    }

}

struct DeviceInfoSelectedServiceCommand: AppCommand {

    let service: Service
    func execute(_ store: AppStore, action: AppAction) {
        store.appState.data.service = service
    }
}

struct DeviceInfoDisplayCharacteristicsCommand: AppCommand {

    let isDisplayCharacteristicsList: Bool
    func execute(_ store: AppStore, action: AppAction) {
        store.appState.appSignal.isDisplayCharacteristicsList = isDisplayCharacteristicsList
    }
    
    init(_ isDisplayCharacteristicsList: Bool) {
        self.isDisplayCharacteristicsList = isDisplayCharacteristicsList
    }

}

struct DeviceInfoUpdateCharacteristicsCommand: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        guard let device = store.appState.data.device, device.characteristics.count == 0, device.isConnected else { return  }
        store.appState.data.device?.characteristics = device.serviceCharacteristics.compactMap {
            Characteristics(service: Service($0.service), characteristic: $0.characteristic)
        }
    }
}
