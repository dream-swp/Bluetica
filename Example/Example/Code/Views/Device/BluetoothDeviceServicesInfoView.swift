//
//  BluetoothDeviceServicesInfoView.swift
//  Example
//
//  Created by Dream on 2025/9/24.
//



import SwiftUI

struct BluetoothDeviceServicesInfoView: View {

    let service: BluetoothService

    let isSelect: Bool

    let action: () -> Void

    var body: some View {

        Button(action: action) {
            HStack(spacing: 12) {
                VStack {
                    Image(systemName: "gear")
                        .font(.title2)
                        .foregroundStyle(isSelect.imageColor)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(isSelect.imageBackgroundColor)
                        )
                    EmptyView().toggle(isSelect) { _ in
                        Circle()
                            .fill(true.imageBackgroundColor)
                            .frame(width: 6, height: 6)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(service.uuid.string)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    Text("UUID: \(service.uuid.string)")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack {
                        Image(systemName: "gear.badge")
                            .font(.caption2)
                            .foregroundStyle(.secondary)

                        Text("\(service.characteristic.count) 个特征")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()

                        EmptyView().toggle(service.isPrimary) { _ in
                            Text("主服务")
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.green.opacity(0.2))
                                .foregroundStyle(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }

                    }
                }

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelect ? Color.blue.opacity(0.1) : .bluetoothCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelect ? Color.blue : Color.clear, lineWidth: 2)
                    )
            )
        }
        .padding(.horizontal, 10)
        .buttonStyle(.plain)

    }
}


private extension Bool {

    var imageColor: Color { self ? .white : .orange }
    var imageBackgroundColor: Color { self ? .orange.opacity(0.8) : .blue.opacity(0.1) }

}

#Preview {

    //    BluetoothDeviceServicesInfoView(isSelect: true) { }
    //    .frame(maxWidth: .infinity, maxHeight: .infinity)
    //    .environmentObject(AppStore())
}
