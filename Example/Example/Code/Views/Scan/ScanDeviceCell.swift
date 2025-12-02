//
//  ScanDeviceCell.swift
//  Example
//
//  Created by Dream on 2025/8/31.
//

import CoreBluetooth
import SwiftUI

struct ScanDeviceCell: View {

    @EnvironmentObject private var appStore: AppStore

    let device: Device

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
        .padding(20)
        .padding(.horizontal, 5)
        
        .background(alignment: .center) {
            bluetoothBackgroundCardStyle
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
        }
        
    }

}

extension ScanDeviceCell {

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
                .foregroundStyle(.secondary)

            serviceView
        }
    }

    private var serviceView: some View {
        Text("标准BLE设备")
            .font(.caption)
            .foregroundStyle(.secondary)
            .toggle(device.isServices) { _ in
                Text("主服务: \(device.serviceNames.prefix(2).joined(separator: ","))")
                    .font(.caption)
                    .foregroundStyle(.blue)
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
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }

        }
    }

    @ViewBuilder
    private var button: some View {
        ButtonView(appStore.appState.appStyle.button.connect) {
            action(false)
        }
        .toggle(device.isConnected) { _ in
            ButtonView(appStore.appState.appStyle.button.deviceInfo) {
                action(true)
            }
        }
    }
}
