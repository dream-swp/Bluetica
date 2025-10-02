//
//  DeviceInfoButtonsView.swift
//  Example
//
//  Created by Dream on 2025/9/17.
//

import SwiftUI

struct DeviceInfoButtonsView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {

        EmptyView().toggle(device) { view, device in
            view.toggle(device.isConnected) {  _ in
                buttons
                infoView
                    .padding(10)
            }
        }

    }
}

extension DeviceInfoButtonsView {
    var buttons: some View {
        VStack(alignment: .leading, spacing: 8) {

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(deviceInfoButtons, id: \.id) { style in
                    ButtonView(style) {
                        appStore.dispatch(.deviceInfo(.buttons(device, .init(style.execute?.command))))
                    }
                }

            }
        }
        .padding(.horizontal, 10)
    }
}

extension DeviceInfoButtonsView {

    private var columns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 20, alignment: .center),
            GridItem(.flexible(), alignment: .center),
        ]
    }

    private var infoView: some View {
        HStack {
            Image(systemName: "info.circle")
                .foregroundStyle(.blue)
                .font(.caption)
            
            Text(servicesMessage)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

extension DeviceInfoButtonsView {
    private var deviceInfoButtons: [AppButtonStyleType] {
        appStore.appState.appStyle.button.deviceOperation
    }
    
    private var device: Device? {
        appStore.appState.data.device
    }
    
    private var servicesMessage: String {
        appStore.appState.data.servicesMessage
    }
}


extension DeviceInfoButtonsView {
    
    enum ButtonType: String {
        case none
        case disconnect
        case subscribe
        case refresh
        case characteristic
        
        init(_ value: String?) {
            switch value {
            case "disconnect": self = .disconnect
            case "subscribe":  self = .subscribe
            case "refresh":  self = .refresh
            case "characteristic":  self = .characteristic
            default:  self = .none
            }
            
        }
    }
    
}

#Preview {
    DeviceInfoButtonsView().environmentObject(AppStore())
}
