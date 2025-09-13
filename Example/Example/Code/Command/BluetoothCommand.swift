//
//  BluetoothCommand.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica
import Combine
import Foundation

struct BluetoothStateCommand: AppCommand, AppUpdateData {

    func execute(in store: AppStore) {
        if store.appState.bluetooth.isEnabled { return }
        let _ = store.appState.bluetica.central
            .updateState { manager, central in
                store.dispatch(.status)
            }
    }

    var update: (() -> AppState) -> AppState {
        return {
            var state = $0()
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

struct BluetoothToggleCommand: AppCommand {

    func execute(in store: AppStore) {
        let isStart = store.appState.bluetooth.isScanning
        let action: AppAction = isStart ? .stop : .start
        store.dispatch(action)

    }
}

struct BluetoothStartCommand: AppCommand, AppUpdateData {
    func execute(in store: AppStore) {
        
        store.appState.bluetica
            .central
            .config { $0.filter { .identifier }.scan { .time(5) } }
            .stopDiscover {
                store.dispatch(.stop)
            }
            .start
        
        store.dispatch(.scan)
    }
    
    var update: (() -> AppState) -> AppState {
        return {
            var state = $0()
            state.bluetooth.isScanning = true
            return state
        }
    }
}

struct BluetoothStopCommand: AppCommand, AppUpdateData {
    func execute(in store: AppStore) {
        let _ = store.appState.bluetica
            .central
            .stop
    }
    
    var update: (() -> AppState) -> AppState {
        return {
            var state = $0()
            state.bluetooth.isScanning = false
            return state
        }
    }

}

struct BluetoothScanCommand: AppCommand {

    func execute(in store: AppStore) {

        let _ = store.appState.bluetica
            .central
            .discover { manager, info in
                let data: BluetoothDevice = .init(device: info.device)
                store.appState.bluetooth.devices.append(data)
                store.dispatch(.scan)
            }
    }
}

struct BluetoothInfoCommand: AppCommand, AppUpdateData {
   
    var device: BluetoothDevice

    func execute(in store: AppStore) {  }

    var update: (() -> AppState) -> AppState {

        return {
            var state = $0()
            state.bluetooth.deviceInfo = device
            return state
        }
    }
    
    
}
