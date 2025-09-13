//
//  BluetoothDeviceBasicInfoView.swift
//  Example
//
//  Created by Dream on 2025/9/9.
//

import SwiftUI

struct BluetoothDeviceBasicInfoView: View {

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                icon

                info
            }
            Spacer()

            divider

            services { (title: "主服务", [GridData(title: "xxxx", subTitle: "181A"), GridData(title: "xxxx", subTitle: "181A")]) }
            
            divider
            
            services { (title: "广播数据", datas: [GridData(title: "xxxx", subTitle: "181A"), GridData(title: "xxxx", subTitle: "181A")]) }

        }
        .padding(25)
        .background(alignment: .center) {
            bluetoothBackgroundCardStyle
                .padding(10)
        }

    }
}

extension BluetoothDeviceBasicInfoView {
    struct GridData: Identifiable {
        let id: UUID = UUID()
        let title: String
        let subTitle: String
    }
}

extension BluetoothDeviceBasicInfoView {

    var icon: some View {
        VStack {
            Image(systemName: "1231231231231".deviceIcon)
                .font(.largeTitle)
                .foregroundStyle(false.connectedColor)

            Circle()
                .fill(true.statusCircleColor)
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

            Text("UUID: dasdasdas")
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
            Text("-40 dBm")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle((-49).rssiColor)
            Spacer()
            Text("未连接")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(false.statusTextColor)
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
                    ],
                    spacing: 8
                ) {
                    ForEach(result.datas) { data in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .font(.subheadline)
                                .foregroundStyle(.primary)

                            Text(data.subTitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .textSelection(.enabled)
                        }
                        .padding(.vertical, 4)
                    }

                }
            }

        }
    }

}

#Preview {
//    BluetoothDeviceBasicInfoView()
}
