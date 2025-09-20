//
//  BluetoothStatusCard.swift
//  Example
//
//  Created by Dream on 2025/8/22.
//

import SwiftUI

struct BluetoothScanControlsView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {

        VStack(spacing: 4) {
            buttons
                .padding(.bottom, 10)

            informationView
                .toggle(isScanning) { _ in
                    progressView
                }
        }
        .transition(.opacity.animation(.easeInOut(duration: 0.9)))
        .animation(.spring(response: 0.9, dampingFraction: 0.8), value: isScanning)
        .padding()

    }

}

extension BluetoothScanControlsView {

    private var buttons: some View {
        HStack(spacing: 12) {

            LazyVGrid(columns: buttonColumns, spacing: 8) {
                
                BluetoothButton(startButtonStyle) {
                    appStore.dispatch(.bluetooth(isScanning ? .stop : .start))
                }

                .toggle(isScanning) {
                    $0.model { stopButtonStyle }
                }
                
                BluetoothButton(clearButtonStyle) {
                    appStore.dispatch(.bluetooth(.cleares))
                }
            }
           

        }

    }

    private var progressView: some View {
        HStack {
            ProgressView()
                .scaleEffect(0.8)
            VStack(alignment: .leading, spacing: 2) {
                Text("正在扫描蓝牙设备...")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("仅显示有主服务的设备")
                    .font(.caption2)
                    .foregroundStyle(.bluetoothText)
            }
        }
    }

    private var informationView: some View {

        VStack(spacing: 4) {
            HStack {
                Image(systemName: "info.circle")
                    .font(.caption2)
                    .foregroundStyle(.bluetoothIcon)
                Text("扫描将按主服务过滤设备，只显示有效的BLE设备")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
    }

}

extension BluetoothScanControlsView {

    private var startButtonStyle: BluetoothButtonStyle {
        appStore.appState.bluetoothViewModel.startButtonStyle
    }

    private var stopButtonStyle: BluetoothButtonStyle {
        appStore.appState.bluetoothViewModel.stopButtonStyle
    }
    
    private var clearButtonStyle: BluetoothButtonStyle {
        appStore.appState.bluetoothViewModel.clearButtonStyle
    }

    private var isScanning: Bool {
        appStore.appState.bluetooth.isScanning
    }
    
    private var buttonColumns: [GridItem] {
        [ GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center), ]
    }

}

#Preview {
    BluetoothScanControlsView()
        .environmentObject(AppStore())
}
