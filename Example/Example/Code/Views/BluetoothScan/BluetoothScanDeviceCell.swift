//
//  BluetoothScanDeviceCell.swift
//  Example
//
//  Created by Dream on 2025/8/31.
//

import CoreBluetooth
import SwiftUI

struct BluetoothScanDeviceCell: View {

    @EnvironmentObject private var appStore: AppStore

    let device: BluetoothDevice

    let action: (Bool) -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                icon
                serviceInfoView
                Spacer()
                signalStatusView
            }

            button
        }
        .padding(30)
        .background(alignment: .center) {
            bluetoothBackgroundCardStyle
                .padding()
        }
    }

}

extension BluetoothScanDeviceCell {

    private var icon: some View {
        Image(systemName: device.name.deviceIcon { device.isConnected })
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(device.isConnected.connectedColor)
    }

    private var serviceInfoView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(device.name)
                .font(.headline)
                .foregroundStyle(.bluetoothText)
                .lineLimit(1)

            Text(device.identifierInfo)
                .font(.caption)
                .foregroundColor(.secondary)

            serviceView
        }
    }

    private var serviceView: some View {
        Text("标准BLE设备")
            .font(.caption)
            .foregroundColor(.secondary)
            .toggle(device.isServices) { _ in
                Text("主服务: \(device.serviceNames.prefix(2).joined(separator: ","))")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }

    }

    private var signalStatusView: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(device.rssiInfo)
                .font(.caption)
                .foregroundStyle(device.rssiValue.rssiColor)
                .fontWeight(.medium)

            Text(device.state.description)
                .font(.caption)
                .foregroundStyle(device.isConnected.connectedColor)

            EmptyView()
                .toggle(device.isServices) { _ in
                    Text("\(device.serviceUUIDs.count) 个服务")
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }

        }
    }

    @ViewBuilder
    private var button: some View {
        BluetoothButton(appStore.appState.bluetoothViewModel.connectButtnStyle) {
            action(false)
        }
        .toggle(device.isConnected) { _ in
            BluetoothButton(appStore.appState.bluetoothViewModel.infoButtnStyle) {
                action(true)
            }
        }
    }
}
