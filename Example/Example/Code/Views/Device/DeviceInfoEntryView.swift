//
//  DeviceInfoView.swift
//  Example
//
//  Created by Dream on 2025/9/8.
//

import SwiftUI

struct DeviceInfoEntryView: View {

    @EnvironmentObject private var appStore: AppStore

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            DeviceInfoStatusView()
            placeholderView
                .toggle(isConnected) { _ in
                    
                    DeviceInfoButtonsView()
                    
                    DeviceInfoServicesListView()
                    
                    DeviceInfoCharacteristicsView()
                    
                    DeviceInfoDataCommunicationView()
                }

        }
        .presentationDetents([.large])
        .navigationTitle("设备详情")
        .navigationBarTitleDisplayModeCompat()
        .toggle(DeviceType.isIphone || DeviceType.isIpad) {
            $0.toolbar {
                ToolbarItem(placement: .navigationBarTrailingCompat) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done").foregroundStyle(.blue)
                    }
                }
            }
        }
        .onAppear {
            appStore.dispatch(.deviceInfo(.updateCharacteristics))
        }
        .sheet(isPresented: $appStore.appState.appSignal.isDisplayCharacteristicsList) {
            
            CharacteristicsEntryView(characteristics: characteristics)
        }
    }
}

extension DeviceInfoEntryView {

    private var placeholderView: some View {
        Group {
            ButtonView(style.button.connect) {
                if let device = device {
                    appStore.dispatch(.connectDevice { device } )
                }
            }
            .padding()
            
            PlaceholderView {
                ("bolt.slash.circle.fill", "设备未连接", "请先连接设备以查看详细信息和进行数据通信")
            }
        }
        .padding(.top, 10)
        
    }
}

extension DeviceInfoEntryView {
    private var isConnected: Bool? {
        appStore.appState.data.device?.isConnected
    }
    
    private var style: AppStyle {
        appStore.appState.appStyle
    }
    
    private var device: Device? {
        appStore.appState.data.device
    }
    
    private var deviceBinding: Binding<Device?> {
        $appStore.appState.data.device
    }
    
    private var characteristic: Binding<Characteristics?> {
        $appStore.appState.data.characteristic
    }
    
    private var characteristics: [Characteristics] {
        appStore.appState.data.device?.characteristics ?? []
    }
    
}

#Preview {
    DeviceInfoEntryView().environmentObject(AppStore())
}
