//
//  BluetoothStatusCard.swift
//  Example
//
//  Created by Dream on 2025/8/27.
//

import SwiftUI

struct BluetoothScanStatusView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        VStack(spacing: 12) {

            informationView

            divider

            statusView
        }
    
        .padding()
        .background(alignment: .center) {
            bluetoothBackgroundCardStyle
        }

    }

}

extension BluetoothScanStatusView {

    private var informationView: some View {
        HStack {
            iconView

            descriptionView

            Spacer()

            indicatorView
        }
    }

    private var iconView: some View {
        Image(systemName: style.bluetoothIcon.icon)
            .toggle(isEnabled) {
                $0.foregroundStyle(style.success.color)
            }
            .foregroundStyle(style.failure.color)
            .font(.title2)
    }

    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(style.statusTitle.text)
                .font(.headline)
                .foregroundStyle(style.textColor.color)

            Text(bluetooth.status)
                .toggle(isEnabled) {
                    $0.foregroundStyle(style.success.color)
                }
                .font(.subheadline)
                .foregroundStyle(style.failure.color)
                .fontWeight(.medium)
        }

    }

    private var indicatorView: some View {
        Circle()
            .fill(style.failure.color)
            .toggle(isEnabled) {
                $0.fill(style.success.color)
            }
            .frame(width: 12, height: 12)
    }
    
    private var statusView: some View {
        HStack {
            Image(systemName: style.infoIcon.icon)
                .foregroundStyle(.bluetoothIcon)
                .font(.caption)
                .fontWeight(.bold)
            Text(bluetooth.message)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

extension BluetoothScanStatusView {
    
    private var style: BluetoothStatusCardStyle { appStore.appState.bluetoothViewModel.statusCarStyle }
    
    private var bluetooth: BluetoothModel { appStore.appState.bluetooth }

    private var isEnabled: Bool { bluetooth.isEnabled }
}

#Preview {
    BluetoothScanStatusView().environmentObject(AppStore())
}
