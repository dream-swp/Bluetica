//
//  BluetoothDeviceInfoButtons.swift
//  Example
//
//  Created by Dream on 2025/9/17.
//

import SwiftUI

struct BluetoothDeviceInfoButtons: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {

        EmptyView().toggle(device) { view, device in
            view.toggle(device.isConnected) {  _ in
                buttons
            }
        }

    }
}

extension BluetoothDeviceInfoButtons {
    var buttons: some View {
        VStack(alignment: .leading, spacing: 8) {

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(deviceInfoButtons, id: \.id) { style in
                    BluetoothButton(style) {
                        appStore.dispatch(.deviceInfo(.deviceInfoButtons(device, .init(style.execute?.command))))
                    }
                }

            }
        }
        .padding(.horizontal, 10)
    }
}

extension BluetoothDeviceInfoButtons {

    private var columns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 20, alignment: .center),
            GridItem(.flexible(), alignment: .center),
        ]
    }

    private var deviceInfoButtons: [BluetoothButtonStyle] {
        appStore.appState.bluetoothViewModel.deviceInfoButtons
    }
    
    private var device: BluetoothDevice? {
        appStore.appState.bluetooth.device
    }
}


extension BluetoothDeviceInfoButtons {
    
    enum ButtonType: String {
        case none
        case disconnect
        case subscribe
        case refresh
        case characteristic
        
        init(_ value: String?) {
            switch value {
            case "disconnect": self = .disconnect
            case "subscribe":  self = .subscribe
            case "refresh":  self = .refresh
            case "characteristic":  self = .characteristic
            default:  self = .none
            }
            
        }
    }
    
}

#Preview {
    BluetoothDeviceInfoButtons().environmentObject(AppStore())
}
