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

struct DeviceInfoDisplayCharacteristicCommand: AppCommand {

    let isDisplayCharacteristicsList: Bool
    func execute(_ store: AppStore, action: AppAction) {
        store.appState.appSignal.isDisplayCharacteristicsList = isDisplayCharacteristicsList
    }

    init(_ isDisplayCharacteristicsList: Bool) {
        self.isDisplayCharacteristicsList = isDisplayCharacteristicsList
    }

}

struct DeviceInfoUpdateCharacteristicCommand: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        guard let device = store.appState.data.device, device.characteristics.count == 0, device.isConnected else { return }
        store.appState.data.device?.characteristics = device.serviceCharacteristics.compactMap {
            Characteristic(service: Service($0.service), characteristic: $0.characteristic)
        }
    }
}

struct DeviceInfoCharacteristicReadData: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {

        guard let characteristic = store.appState.data.characteristic else { return }
        let _ = store.appState.bluetica.central
            .readData { characteristic.characteristic }

        store.dispatch(.deviceInfo(.updateData))
    }

}

struct DeviceInfoCharacteristicUpdateData: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        let _ = store.appState.bluetica.central
            .updateValue { _, data, _ in
                if let data = data { store.appState.data.characteristic?.read.data = data }
            }
    }
}

struct DeviceInfoCharacteristicSendData: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {
        guard let characteristic = store.appState.data.characteristic?.characteristic else { return }

        var data = store.appState.appSignal.characteristicSendText.convert.data

        switch store.appState.appSignal.characteristicSelectedWriteDataItem {
        case .string:
            data = store.appState.appSignal.characteristicSendText.convert.data
        case .hex:
            data = store.appState.appSignal.characteristicSendText.convert.hex
        case .decimal:
            data = store.appState.appSignal.characteristicSendText.convert.decimal
        case .binary:
            data = store.appState.appSignal.characteristicSendText.convert.binary
        case .base64:
            data = store.appState.appSignal.characteristicSendText.convert.base64
        }

        store.appState.data.characteristic?.write.data = data

        let parameter = (data, characteristic)
        switch store.appState.appSignal.characteristicSelectedWriteModeItem {
        case .writeResponse:
            let _ = store.appState.bluetica.central.writeDataResponse { parameter }
        case .writeWithoutResponse:
            let _ = store.appState.bluetica.central.writeDataWithoutResponse { parameter }
        }
    }
}

struct DeviceInfoCharacteristicNotify: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {
        guard let characteristic = store.appState.data.characteristic else { return }
        store.dispatch(.deviceInfo(characteristic.isNotifying ? .unsubscribeNotify : .subscribeNotify))
    }

}

struct DeviceInfoCharacteristicSubscribeNotify: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {
        guard let characteristic = store.appState.data.characteristic else { return }
        let _ = store.appState.bluetica.central
            .subscribeNotify {
                characteristic.characteristic
            }
        store.dispatch(.deviceInfo(.updateData))
    }
}

struct DeviceInfoCharacteristicUnsubscribeNotify: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        guard let characteristic = store.appState.data.characteristic else { return }
        let _ = store.appState.bluetica.central
            .unSubscribeNotify {
                characteristic.characteristic
            }
            .updateNotificationState { manager, info in
                if let update = info.update {
                    store.appState.data.characteristic? = Characteristic(service: characteristic.service, characteristic: update)
                }
            }

    }

}
