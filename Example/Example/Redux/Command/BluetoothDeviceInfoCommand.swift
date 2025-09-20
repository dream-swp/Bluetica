//
//  BluetoothDeviceInfoCommand.swift
//  Example
//
//  Created by Dream on 2025/9/20.
//

import Bluetica
import Foundation

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
            break
        case .characteristic:
            break
        }
    }

}
