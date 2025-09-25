//
//  BluetoothDeviceServicesListView.swift
//  Example
//
//  Created by Dream on 2025/9/21.
//

import Bluetica
import SwiftUI

struct BluetoothDeviceInfoServicesView: View {

    @EnvironmentObject private var appStore: AppStore
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(services, id: \.service.uuid) { service in
                    BluetoothDeviceServicesInfoView(service: service ,isSelect: self.service?.uuid == service.uuid) {
                        appStore.dispatch(.deviceInfo(.deviceInfoService(service)))
                    }
                }
            }
        }
    }
}



extension BluetoothDeviceInfoServicesView {

    private var services: [BluetoothService] {
        appStore.appState.bluetooth.device?.services ?? []
    }

    private var service: BluetoothService? {
        appStore.appState.bluetooth.device?.service
    }

    private func serviceIcon(_ uuid: String) -> String {
        switch uuid.uppercased() {
        case "180F":
            return "battery.100"
        case "180A":
            return "info.circle"
        case "1800":
            return "person.circle"
        case "1801":
            return "gearshape"
        case "180D":
            return "heart"
        case "1810":
            return "drop"
        case "181A":
            return "thermometer"
        case "181C":
            return "person.crop.circle"
        case "181D":
            return "scalemass"
        case "1822":
            return "lungs"
        case "1826":
            return "figure.run"
        default:
            return "gear"
        }
    }
}

#Preview {
    BluetoothDeviceInfoServicesView().environmentObject(AppStore())
}
