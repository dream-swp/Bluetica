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
        let _ = store
            .appState
            .bluetica
            .central
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

struct BluetoothStartCommand: AppCommand, AppUpdateData {

    func execute(_ store: AppStore, action: AppAction) {

        store.appState.bluetica
            .central
            .config {
                $0.filter { .identifier }.scan { .time(20) }
            }
            .stopDiscover {
                store.dispatch(.bluetooth(.stop))
            }
            .start
        store.dispatch(.bluetooth(.scan))
    }

    var update: (() -> (state: AppState, action: AppAction)) -> AppState {
        return {
            var state = $0().state
            state.bluetooth.isScanning = true
            return state
        }
    }
}

struct BluetoothStopCommand: AppCommand, AppUpdateData {
    func execute(_ store: AppStore, action: AppAction) {
        let _ = store.appState.bluetica
            .central
            .stop
    }

    var update: (() -> (state: AppState, action: AppAction)) -> AppState {
        return {
            var state = $0().state
            state.bluetooth.isScanning = false
            return state
        }
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

struct BluetoothDeviceCommand: AppCommand, AppUpdateData {

    var device: BluetoothDevice

    func execute(_ store: AppStore, action: AppAction) {}

    var update: (() -> (state: AppState, action: AppAction)) -> AppState {
        return {
            var state = $0().state
            state.bluetooth.device = device
            return state
        }
    }
}

struct BluetoothConnectCommand: AppCommand, AppUpdateData {

    var device: BluetoothDevice

    func execute(_ store: AppStore, action: AppAction) {

        let _ = store.appState.bluetica
            .central
            .connect {
                device.peripheral
            }.connectSuccess { manager, info in
                if let aDevice = info.device {
                    store.appState.bluetooth.device?.device = aDevice
                }
            }
            .disconnectPeripheral { manager, info in
                if let aDevice = info.device {
                    store.appState.bluetooth.device?.device = aDevice
                }
            }

    }

    var update: (() -> (state: AppState, action: AppAction)) -> AppState {
        return { $0().state }
    }

}

struct BluetoothDisconnectCommand: AppCommand, AppUpdateData {

    var device: BluetoothDevice?
    var isClearAll = true

    func execute(_ store: AppStore, action: AppAction) {

        if isClearAll {
            let _ = store.appState.bluetica.central.clearDevice

        }

    }

    var update: (() -> (state: AppState, action: AppAction)) -> AppState {
        return {
            var state = $0().state
            if isClearAll {
                state.bluetooth.devices.removeAll()
            }
            return state
        }
    }

}
