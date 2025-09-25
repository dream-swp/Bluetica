//
//  BluetoothDeviceInfo.swift
//  Example
//
//  Created by Dream on 2025/9/8.
//

import CoreBluetooth
import SwiftUI

struct BluetoothDeviceInfoView: View {

    @EnvironmentObject private var appStore: AppStore

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            BluetoothDeviceInfoStatusView()
            placeholderView
                .toggle(isConnected) { _ in
                    BluetoothDeviceInfoButtons()
                    
                    BluetoothDeviceInfoServicesView()
                    
                    BluetoothDeviceCharacteristicsInfoView()
                }
                

        }
        .navigationTitle("设备详情")
        .navigationBarTitleDisplayModeCompat()
        .toggle(DeviceType.isIphone || DeviceType.isIpad) {
            $0.toolbar {
                ToolbarItem(placement: .navigationBarTrailingCompat) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done").foregroundStyle(.blue)
                    }
                }
            }
        }

    }
}

extension BluetoothDeviceInfoView {

    private var placeholderView: some View {
        Group {
            BluetoothButton(viewModel.connectButtnStyle) {
                if let device = device {
                    appStore.dispatch(.bluetooth(.connect(device)))
                }
            }
            .padding()
            
            BluetoothPlaceholderView {
                ("bolt.slash.circle.fill", "设备未连接", "请先连接设备以查看详细信息和进行数据通信")
            }
        }
        .padding(.top, 10)
        
    }
}

extension BluetoothDeviceInfoView {
    private var isConnected: Bool? {
        appStore.appState.bluetooth.device?.isConnected
    }
    
    private var viewModel: BluetoothViewModel {
        appStore.appState.bluetoothViewModel
    }
    
    private var device: BluetoothDevice? {
        appStore.appState.bluetooth.device
    }
}

#Preview {
    BluetoothDeviceInfoView().environmentObject(AppStore())
}
