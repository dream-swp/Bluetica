//
//  BluetoothDeviceInfo.swift
//  Example
//
//  Created by Dream on 2025/9/8.
//

import CoreBluetooth
import SwiftUI

struct BluetoothDeviceInfoView: View {

    let device: BluetoothDevice

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        //        NavigationView {
        ScrollView {
            BluetoothDeviceBasicInfoView()
        }
        .navigationTitle("设备详情")
        .navigationBarTitleDisplayModeCompat()
        .toggle(DeviceType.isIphone) {
            $0
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailingCompat) {
                    Button { dismiss() } label: {
                        Text("Done").foregroundStyle(.blue)
                    }

                }
            }
        }

    }
}

#Preview {
    //    BluetoothDeviceInfoView()
}
