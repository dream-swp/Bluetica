//
//  ScanStatusView.swift
//  Example
//
//  Created by Dream on 2025/8/27.
//

import SwiftUI

struct ScanStatusView: View {

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

extension ScanStatusView {

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
            .foregroundStyle(style.foregroundStyle.color)
            .font(.title2)
    }

    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(style.statusTitle.text)
                .font(.headline)
                .foregroundStyle(style.textColor.color)

            Text(appStore.appState.message.status)
                .font(.subheadline)
                .foregroundStyle(style.foregroundStyle.color)
                .fontWeight(.medium)
        }

    }

    private var indicatorView: some View {
        Circle()
            .fill(style.foregroundStyle.color)
            
            .frame(width: 12, height: 12)
    }
    
    private var statusView: some View {
        HStack {
            Image(systemName: style.infoIcon.icon)
                .foregroundStyle(.bluetoothIcon)
                .font(.caption)
                .fontWeight(.bold)
            Text(signal.message)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

extension ScanStatusView {
    
    private var style: ScanStatusStyleType {
        isEnabled ? appStore.appState.appStyle.scan.success : appStore.appState.appStyle.scan.failure
    }
    
    private var signal: DataSignal { appStore.appState.data }

    private var isEnabled: Bool { signal.isEnabled }
}

#Preview {
    ScanStatusView().environmentObject(AppStore())
}
