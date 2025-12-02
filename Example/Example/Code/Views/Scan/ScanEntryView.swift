//
//  ScanEntryView.swift
//  Example
//
//  Created by Dream on 2025/8/22.
//

import SwiftUI

struct ScanEntryView: View {

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

extension ScanEntryView {

    private var buttons: some View {
        HStack(spacing: 12) {

            LazyVGrid(columns: buttonColumns, spacing: 8) {
                
                ButtonView(startButtonStyle) {
                    
                    appStore.dispatch(isScanning ? .stop : .start)
                }

                .toggle(isScanning) {
                    $0.style {
                        stopButtonStyle
                    }
                }
                
                ButtonView(clearButtonStyle) {
                    appStore.dispatch(.clearesDevice)
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

extension ScanEntryView {

    private var startButtonStyle: AppButtonStyleType {
        appStore.appState.appStyle.button.start
    }

    private var stopButtonStyle: AppButtonStyleType {
        appStore.appState.appStyle.button.stop
    }
    
    private var clearButtonStyle: AppButtonStyleType {
        appStore.appState.appStyle.button.clear
    }

    private var isScanning: Bool {
        appStore.appState.data.isScanning
    }
    
    private var buttonColumns: [GridItem] {
        [ GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center), ]
    }

}

#Preview {
    ScanEntryView()
        .environmentObject(AppStore())
}
