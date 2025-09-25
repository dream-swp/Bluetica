//
//  BluetoothCommand.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica
import Foundation

struct BluetoothStateCommand: AppCommand, AppUpdateData {

    func execute(_ store: AppStore, action: AppAction) {
        if store.appState.bluetooth.isEnabled { return }
        let _ = store.appState.bluetica.central
            .updateState { manager, central in
                store.dispatch(.bluetooth(.status))
            }
    }

    var update: (() -> (state: AppState, action: AppAction)) -> AppState {
        return {
            var state = $0().state
            let isEnabled = state.bluetica.central.isEnabled
            state.bluetooth.isEnabled = isEnabled
            let bluetoothIcon = isEnabled ? BluetoothStatusCardStyle.iconSuccess : BluetoothStatusCardStyle.iconFailure
            state.bluetoothViewModel.statusCarStyle.bluetoothIcon = bluetoothIcon
            state.bluetooth.status = statusMessage { state.bluetica }
            return state
        }
    }

    var statusMessage: (() -> Bluetica) -> String {
        return {
            let bluetica = $0()

            var message = ""
            switch bluetica.central.status {
            case .poweredOn:
                message = "蓝牙已开启，可以开始使用"
            case .poweredOff:
                message = "蓝牙已关闭，请开启蓝牙"
            case .unauthorized:
                message = "蓝牙权限未授权"
            default:
                message = bluetica.central.status.description
            }

            return message
        }
    }
}

struct BluetoothStartCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {

        if store.appState.bluetooth.isEnabled == false { return }
        store.appState.bluetica
            .central
            .config {
                $0.filter { .identifier }.scan { .time(15) }
            }
            .stopDiscover {
                store.dispatch(.bluetooth(.stop))
            }
            .start
        store.appState.bluetooth.isScanning = true
        store.dispatch(.bluetooth(.scan))
    }

}

struct BluetoothStopCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {
        let _ = store.appState.bluetica
            .central
            .stop
        store.appState.bluetooth.isScanning = false
    }
}

struct BluetoothScanCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {

        let _ = store.appState.bluetica
            .central
            .discover { manager, info in
                let data: BluetoothDevice = .init(device: info.device)
                store.appState.bluetooth.devices.append(data)
                store.dispatch(.bluetooth(.scan))
            }
    }
}

struct BluetoothDeviceCommand: AppCommand {

    var device: BluetoothDevice

    func execute(_ store: AppStore, action: AppAction) {
        store.appState.bluetooth.device = device
    }
}

struct BluetoothConnectCommand: AppCommand {

    let device: BluetoothDevice

    func execute(_ store: AppStore, action: AppAction) {

        var _ = store.appState.bluetica
            .central
            .connect {
                device.peripheral
            }.connectSuccess { manager, info in
                info.device.map { store.appState.bluetooth.device = BluetoothDevice(device: $0) }
            }
            .disconnectPeripheral { manager, info in
                if store.appState.bluetooth.devices.count > 0 {
                    info.device.map { store.appState.bluetooth.device = BluetoothDevice(device: $0) }
                }
            }
            .discoverServices { manager, info in
                store.appState.bluetooth.servicesMessage = "自动检索服务成功"
            }
            .discoverCharacteristics { manager, info in
                if let services = info.device?.services {
                    store.appState.bluetooth.device?.services = services.compactMap { BluetoothService(service: $0) }
                }
            }
    }
}

struct BluetoothClearesDeviceCommand: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        let _ = store.appState.bluetica.central.clearDevice
        store.appState.bluetooth.devices.removeAll()
        store.appState.bluetooth.device = nil
    }
}
