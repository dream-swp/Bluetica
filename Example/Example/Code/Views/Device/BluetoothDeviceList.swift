//
//  BluetoothDeviceList.swift
//  Example
//
//  Created by Dream on 2025/8/30.
//


import SwiftUI

struct BluetoothDeviceList: View {
    
    
    @EnvironmentObject private var appStore: AppStore
    
    var body: some View {
        
        headerView
            .padding()
        
        placeholderView
            .toggle(bluetooth.isDevices) { _ in
                listView
        }
    }
}

extension BluetoothDeviceList {
    
    
    var headerView: some View {
        HStack {
            
            Text("发现的设备 (\(bluetooth.devices.count))")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
                
            EmptyView()
                .toggle(bluetooth.isDevices) { _ in
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("点击卡片连接设备")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("已按主服务过滤")
                            .font(.caption2)
                            .foregroundColor(.blue)
                    }
                }
            
            
        }
    }
    
    var placeholderView: some View {
        
        VStack(spacing: 12) {
            Image(systemName: "antenna.radiowaves.left.and.right.slash")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text("暂无发现设备")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("请点击\"开始扫描\"按钮搜索附近的蓝牙设备")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
    
    var listView: some View {
        ScrollView {
            
            ForEach(bluetooth.devices) {
                BluetoothDeviceCell(device: $0)
            }
            .onTapGesture {
                print("1")
            }
            
        }
    }
}


extension BluetoothDeviceList {
    private var bluetooth: BluetoothModel {
        appStore.appState.bluetooth
    }
}

#Preview {
    BluetoothDeviceList().environmentObject(AppStore())
}
