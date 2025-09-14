//
//  BluetoothDeviceBasicInfoView.swift
//  Example
//
//  Created by Dream on 2025/9/9.
//

import SwiftUI

struct BluetoothDeviceBasicInfoView: View {

    let device: BluetoothDevice

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                icon

                info
            }
            Spacer()

            divider

            EmptyView()
                .toggle(primaryServices.count > 0) { _ in
                    services { (title: "主服务", datas: primaryServices) }
                    divider

                }

            EmptyView()
                .toggle(advertisement.count > 0) { _ in
                    services { (title: "广播数据", datas: advertisement) }
                }
        }
        .padding(25)
        .background(alignment: .center) { bluetoothBackgroundCardStyle.padding(10) }

    }
}
extension BluetoothDeviceBasicInfoView {

    var icon: some View {
        VStack {
            Image(systemName: device.name.deviceIcon { false })
                .font(.largeTitle)
                .foregroundStyle(device.isConnected.connectedColor)

            Circle()
                .fill(device.isConnected.connectedColor)
                .frame(width: 8, height: 8)
        }
    }

    var info: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("设备名称")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .padding(.top, 5)

            Text("UUID: \(device.id.string)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .textSelection(.enabled)
            status
        }
    }

    var status: some View {
        HStack {
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
                .foregroundStyle(false.connectedColor)
        }
    }

    func services(_ datas: () -> (title: String, datas: [GridData])) -> some View {

        let result = datas()

        return EmptyView().toggle(true) { _ in

            VStack(alignment: .leading, spacing: 8) {
                Text(result.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), alignment: .leading),
                        GridItem(.flexible(), alignment: .leading),
                    ], spacing: 8) {
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

extension BluetoothDeviceBasicInfoView {
    struct GridData: Identifiable {
        let id: UUID = UUID()
        let key: String
        let value: String
    }
}

extension BluetoothDeviceBasicInfoView {

    var primaryServices: [GridData] {

        let uuids = device.services
        let names = device.serviceNames
        var result: [GridData] = []
        for (index, uuid) in uuids.enumerated() {
            let name = names[index]
            let data = GridData(key: name, value: uuid.string)
            result.append(data)
        }

        return result
    }

    var advertisement: [GridData] {

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
}

#Preview {
    //    BluetoothDeviceBasicInfoView()
}
