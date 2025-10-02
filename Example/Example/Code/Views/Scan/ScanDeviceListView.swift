//
//  ScanDeviceListView.swift
//  Example
//
//  Created by Dream on 2025/8/30.
//

import SwiftUI

struct ScanDeviceListView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {

        headerView
            .padding()

        PlaceholderView {
            ("list.bullet.rectangle.fill", "暂无发现设备", "请点击\"开始扫描\"按钮搜索附近的蓝牙设备")
        }
        .toggle(isDevices) { _ in
            listView
        }
    }
}

extension ScanDeviceListView {

    var headerView: some View {
        HStack {

            Text("发现的设备 (\(signal.devices.count))")
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
            ForEach(signal.devices) { data in
                ScanDeviceCell(device: data) {
                    
                    appStore.dispatch($0 ? .selectedDevice { data } : .connectDevice { data })
                }
                .onTapGesture {
                    appStore.dispatch(.selectedDevice { data })
                }
            }
        }
    }
}

extension ScanDeviceListView {
    private var signal: DataSignal { appStore.appState.data }

    private var isDevices: Bool { signal.isDevices }
}

#Preview {
    ScanDeviceListView().environmentObject(AppStore())
}
