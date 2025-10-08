//
//  ScanCommand.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica
import Foundation

struct ScanStateCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {

        let _ = store.appState.bluetica.central
            .updateState { manager, central in
                store.appState.data.isEnabled = manager.central.isEnabled
                store.appState.data.status = manager.central.status.description
                if manager.central.isEnabled {
                    store.dispatch(.status)
                } else {
                    store.dispatch(.stop)
                }
            }
    }
}

struct ScanStartCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {

        if store.appState.data.isEnabled == false { return }
        store.appState.bluetica
            .central
            .config {
                $0.filter { .identifier }.scan { .time(15) }
            }
            .stopDiscover {
                store.dispatch(.stop)
            }
            .start
        store.appState.data.isScanning = true
        store.dispatch(.scanDevice)
    }

}

struct ScanStopCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {
        let _ = store.appState.bluetica
            .central
            .stop
        store.appState.data.isScanning = false
    }
}

struct ScanDeviceCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {

        let _ = store.appState.bluetica
            .central
            .discover { manager, info in
                let data: Device = .init(info.device)
                store.appState.data.devices.append(data)
                store.dispatch(.scanDevice)
            }
    }
}

struct ScanSelectedDeviceCommand: AppCommand {

    var device: Device

    func execute(_ store: AppStore, action: AppAction) {
        store.appState.data.device = device
    }
}

struct ScanConnectDeviceCommand: AppCommand {

    let device: Device

    func execute(_ store: AppStore, action: AppAction) {

        var _ = store.appState.bluetica.central
            .connect {
                device.peripheral
            }.connectSuccess { manager, info in
                info.device.map { store.appState.data.device = Device($0) }
            }
            .disconnectPeripheral { manager, info in
                if store.appState.data.devices.count > 0 {
                    info.device.map { store.appState.data.device = Device($0) }
                }

                store.appState.appSignal.isDisplayCharacteristicsList = false
            }
            .discoverServices { manager, info in
                store.appState.data.servicesMessage = "自动检索服务成功"
            }
            .discoverCharacteristics { manager, info in
                if let device = info.device {
                    store.appState.data.device?.services = device.services.compactMap { Service($0) }
                    store.appState.data.device?.characteristics = device.serviceCharacteristics.compactMap {
                        Characteristics(service: Service($0.service), characteristic: $0.characteristic)
                    }
                }
            }

    }
}

struct ScanClearesDeviceCommand: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        let _ = store.appState.bluetica.central.clearDevice
        store.appState.data.devices.removeAll()
        store.appState.data.device = nil
    }
}
