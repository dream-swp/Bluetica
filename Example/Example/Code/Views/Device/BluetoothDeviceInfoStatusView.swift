//
//  BluetoothDeviceBasicInfoView.swift
//  Example
//
//  Created by Dream on 2025/9/9.
//

import SwiftUI

struct BluetoothDeviceInfoStatusView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        EmptyView()
            .toggle(device) { _, device in
                VStack(spacing: 16) {
                    HStack {
                        icon { device }

                        info { device }
                    }
                    Spacer()

                    divider

                    EmptyView()
                        .toggle(primaryServices { device }.count > 0) { _ in
                            services { (title: "主服务", columns, datas: primaryServices { device }) }
                            divider

                        }

                    EmptyView()
                        .toggle(advertisement { device }.count > 0) { _ in
                            services { (title: "广播数据", columns, datas: advertisement { device }) }
                        }
                }
            }

            .padding(25)
            .background(alignment: .center) { bluetoothBackgroundCardStyle.padding(10) }

    }
}
extension BluetoothDeviceInfoStatusView {

    private func icon(_ handler: () -> (BluetoothDevice)) -> some View {
        VStack {
            let device = handler()
            Image(systemName: device.name.deviceIcon { device.isConnected })
                .font(.largeTitle)
                .foregroundStyle(device.isConnected.connectedColor)

            Circle()
                .fill(device.isConnected.connectedColor)
                .frame(width: 8, height: 8)
        }
    }

    private func info(_ handler: () -> (BluetoothDevice)) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            let device = handler()
            Text("设备名称")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .padding(.top, 5)

            Text("UUID: \(device.id.string)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textSelection(.enabled)
            status { device }
        }
    }

    private func status(_ handler: () -> (BluetoothDevice)) -> some View {
        HStack {
            let device = handler()
            Text("信号强度:")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("\(device.rssiInfo) dBm")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(device.rssiValue.rssiColor)
            Spacer()
            Text(device.state.description)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(device.isConnected.connectedColor)
        }
    }

    private func services(_ datas: () -> (title: String, columns: [GridItem], datas: [GridData])) -> some View {

        let result = datas()

        return EmptyView()
            .toggle(true) { _ in
                VStack(alignment: .leading, spacing: 8) {
                    Text(result.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    LazyVGrid(columns: result.columns, spacing: 8) {
                        ForEach(result.datas) { data in
                            VStack(alignment: .leading, spacing: 2) {
                                Text(data.key)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                Text(data.value)
                                    .font(.caption2)
                                    .foregroundStyle(.primary)
                                    .textSelection(.enabled)
                            }
                            .padding(.vertical, 4)
                        }

                    }
                }
            }
    }

}

extension BluetoothDeviceInfoStatusView {
    private struct GridData: Identifiable {
        let id: UUID = UUID()
        let key: String
        let value: String
    }
}

extension BluetoothDeviceInfoStatusView {

    private func primaryServices(_ handler: () -> (BluetoothDevice)) -> [GridData] {

        let device = handler()
        let uuids = device.serviceUUIDs
        let names = device.serviceNames
        var result: [GridData] = []
        for (index, uuid) in uuids.enumerated() {
            let name = names[index]
            let data = GridData(key: name, value: uuid.string)
            result.append(data)
        }

        return result
    }

    private func advertisement(_ handler: () -> (BluetoothDevice)) -> [GridData] {

        let device = handler()
        let data = device.advertisement
        let keys = data.keys
        var result: [GridData] = []
        for key in keys {
            if let value = data[key] {
                let data = GridData(key: key, value: String("\(value)"))
                result.append(data)
            }
        }

        return result
    }

    private var device: BluetoothDevice? {
        appStore.appState.bluetooth.device
    }

    private var columns: [GridItem] {
        [
            GridItem(.flexible(), alignment: .leading),
            GridItem(.flexible(), alignment: .leading),
        ]
    }

}

#Preview {
    BluetoothDeviceInfoStatusView()
        .environmentObject(AppStore())
}
