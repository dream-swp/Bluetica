//
//  BluetoothScanDeviceCell.swift
//  Example
//
//  Created by Dream on 2025/8/31.
//

import CoreBluetooth
import SwiftUI

struct BluetoothScanDeviceCell: View {

    let device: BluetoothDevice
    
    let action: (Bool) -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                icon
                serviceInfoView
                Spacer()
                signalStatusView
            }

            button
        }.padding(30)
        
        .background(alignment: .center) {
            bluetoothBackgroundCardStyle
                .padding()
        }
    }

}

extension BluetoothScanDeviceCell {

    private var icon: some View {
        Image(systemName: device.name.deviceIcon { device.isConnected })
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.green)
    }

    private var serviceInfoView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(device.name)
                .font(.headline)
                .foregroundStyle(.bluetoothText)
                .lineLimit(1)
            
            Text(device.identifierInfo)
                .font(.caption)
                .foregroundColor(.secondary)

            serviceView
        }
    }

    private var serviceView: some View {
        Text("标准BLE设备")
            .font(.caption)
            .foregroundColor(.secondary)
            .toggle(device.isServices) { _ in
                Text("主服务: \(device.serviceNames.prefix(2).joined(separator: ","))")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }
       
    }

    private var signalStatusView: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(device.rssiInfo)
                .font(.caption)
                .foregroundStyle(device.rssiValue.rssiColor)
                .fontWeight(.medium)

            
            Text(device.state.description)
                .font(.caption)
                .foregroundStyle(.secondary)
//                .toggle(device.isConnected) { _ in
//                    Text("已连接")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                        .fontWeight(.bold)
//                }

            EmptyView()
                .toggle(device.isServices) { _ in
                    Text("\(device.services.count) 个服务")
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
           
        }
    }

    private var button: some View {
        Button {
            action(false)
        } label: {
            HStack {
                Image(systemName: "link")
                Text("连接设备")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
        .toggle(device.isConnected) { _ in
            Button {
                action(true)
            } label: {
                HStack {
                    Image(systemName: "info.circle")
                    Text("查看详情")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .tag(1)
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    //    BluetoothDeviceCard(device: BluetoothDevice(peripheral: CBPeripheral(), rssi: <#NSNumber#>, advertisementData: <#[String : Any]#>))
}
