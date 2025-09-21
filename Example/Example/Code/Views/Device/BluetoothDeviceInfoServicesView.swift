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
                ForEach(services, id: \.id) { service in
                    BluetoothDeviceServicesInfoView()
                }
            }
        }
    }
}

struct BluetoothDeviceServicesInfoView: View {

    var body: some View {
        
        Button {
            
        } label: {
            HStack(spacing: 12) {
                VStack {
                    Image(systemName: "gear")
                        .font(.title2)
                        .foregroundStyle(true ? .white : .blue)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(true ? Color.blue : Color.blue.opacity(0.1))
                        )
                }
                
            }
            
        }
        .buttonStyle(.plain)
    }
}

extension BluetoothDeviceInfoServicesView {

    private var services: [BlueticaCentral.Service] {
        appStore.appState.bluetooth.device?.services ?? []
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
