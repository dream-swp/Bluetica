//
//  DeviceInfoCharacteristicsView.swift
//  Example
//
//  Created by Dream on 2025/9/21.
//

import SwiftUI

struct DeviceInfoCharacteristicsView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(message)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Text("\(characteristics.count) 个特征")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundStyle(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                Button {
                    appStore.dispatch(.deviceInfo(.refreshCharacteristic))
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.caption)
                        .foregroundStyle(.blue)

                }.buttonStyle(.plain)

            }
            .padding(.top, 10)
            .padding(.horizontal, 20)

            EmptyView().toggle(description) { _, value in
                Text(value)
                    .font(.system(.caption, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
                    .background(.bluetoothCardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .textSelection(.enabled)
            }

        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.bluetoothCardBackground)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

        )
        .padding(.horizontal, 10)

    }
}

extension DeviceInfoCharacteristicsView {

    private var device: Device? {
        appStore.appState.data.device
    }

    private var description: String? {
        device?.description
    }

    private var characteristics: [Characteristic] {
        device?.characteristics ?? []
    }

    private var message: String {
        "服务和特征" + appStore.appState.message.servicesAndCharacteristic
    }
}

#Preview {
    DeviceInfoCharacteristicsView()
}
