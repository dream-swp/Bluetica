//
//  DeviceInfoDataCommunicationView.swift
//  Example
//
//  Created by Dream on 2025/9/26.
//

import SwiftUI

struct DeviceInfoDataCommunicationView: View {
    
    @EnvironmentObject private var appStore: AppStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("数据通信")
                .font(.headline)
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("选择特征:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    
                    Text("共 \(characteristics.count) 个")
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(characteristics.isEmpty ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
                        .foregroundStyle(characteristics.isEmpty ? .red : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                }
                
                Button {
                    appStore.dispatch(.deviceInfo(.displayCharacteristicsList(characteristics.count > 0)))
                } label: {
                    HStack {
                        Text(characteristicName)
                            .foregroundStyle(characteristicNameColor)
                        
                        Spacer()
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundStyle(.red)
                            .toggle(characteristics.count > 0) { _ in
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.blue)
                            }
                    }
                    .padding()
                    .background(.bluetoothCardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(characteristics.count < 0)
                .buttonStyle(.plain)
            }
        }
        .padding()
    }
}


extension DeviceInfoDataCommunicationView {
    
    private var device: Device? {
        appStore.appState.data.device
    }
     
    private var characteristics: [Characteristics]  {
        device?.characteristics ?? []
    }
    
    private var characteristic: Characteristics? {
        appStore.appState.data.characteristic
    }
    
}

private extension DeviceInfoDataCommunicationView {
 
    var characteristicName: String  {
        characteristic?.name ?? "请选择特征"
    }
    
    var characteristicNameColor: Color {
        characteristic != nil ? .primary : .secondary
    }
}
