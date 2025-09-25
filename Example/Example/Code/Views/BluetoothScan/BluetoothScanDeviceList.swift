//
//  BluetoothDeviceList.swift
//  Example
//
//  Created by Dream on 2025/8/30.
//

import SwiftUI

struct BluetoothScanDeviceList: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {

        headerView
            .padding()

        BluetoothPlaceholderView {
            ("list.bullet.rectangle.fill", "暂无发现设备", "请点击\"开始扫描\"按钮搜索附近的蓝牙设备")
        }
        .toggle(isDevices) { _ in
            listView
        }
    }
}

extension BluetoothScanDeviceList {

    var headerView: some View {
        HStack {

            Text("发现的设备 (\(bluetooth.devices.count))")
                .font(.headline)
                .foregroundStyle(.primary)

            Spacer()

            EmptyView()
                .toggle(isDevices) { _ in
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("点击卡片连接设备")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("已按主服务过滤")
                            .font(.caption2)
                            .foregroundStyle(.blue)
                    }
                }

        }
    }

    var listView: some View {
        ScrollView {
            ForEach(bluetooth.devices) { data in
                BluetoothScanDeviceCell(device: data) {
                    appStore.dispatch(.bluetooth($0 ? .device(data) : .connect(data)))
                }
                .onTapGesture {
                    appStore.dispatch(.bluetooth(.device(data)))
                }
            }
        }
    }
}

extension BluetoothScanDeviceList {
    private var bluetooth: BluetoothModel { appStore.appState.bluetooth }

    private var isDevices: Bool { bluetooth.isDevices }
}

#Preview {
    BluetoothScanDeviceList().environmentObject(AppStore())
}
