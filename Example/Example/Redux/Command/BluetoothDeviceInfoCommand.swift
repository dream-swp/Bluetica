//
//  BluetoothDeviceInfoCommand.swift
//  Example
//
//  Created by Dream on 2025/9/20.
//

import Bluetica
import Foundation
import CoreBluetooth

struct BluetoothDeviceInfoButtonsCommand: AppCommand {

    let device: BluetoothDevice?
    let command: BluetoothDeviceInfoButtons.ButtonType

    func execute(_ store: AppStore, action: AppAction) {

        switch command {
        case .none:
            break
        case .disconnect:
            let _ = store.appState.bluetica.central.cancel { device?.peripheral }
        case .subscribe:
            break
        case .refresh:
//            let a = store.appState.bluetooth.device?.device.service
//            let b = store.appState.bluetooth.device?.device.characteristics
//            let c = store.appState.bluetooth.device?.device.serviceCharacteristics
            print("12312")
            break
        case .characteristic:
            break
        }
    }

}

struct BluetoothDeviceAutoDiscoverServices: AppCommand {
    func execute(_ store: AppStore, action: AppAction) {
        
    }

    
}
