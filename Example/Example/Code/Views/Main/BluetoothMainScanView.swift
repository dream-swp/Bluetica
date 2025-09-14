//
//  BluetoothScanMain.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica
import SwiftUI

struct BluetoothMainScanView: View {

    @EnvironmentObject private var appStore: AppStore

    private var device: Binding<BluetoothDevice?> {
        $appStore.appState.bluetooth.deviceInfo
    }

    @State var viewModel = BluetoothViewModel()
    var body: some View {
        
        ScrollView {
            BluetoothScanStatusView()
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            BluetoothScanControlsView()

            BluetoothScanDeviceList()
        }
        .navigationTitle("蓝牙扫描")
        .onAppear {
            appStore.dispatch(.bluetooth(.status))
        }
        .toggle(DeviceType.isIphone) {
            $0.sheet(item: device) { device in
                NavigationView { BluetoothDeviceInfoView(device: device) }
            }
        }
    }

}

extension BluetoothMainScanView {

    func test() {

    }
}

#Preview {
    BluetoothMainScanView().environmentObject(AppStore())
}
