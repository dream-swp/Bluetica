//
//  ScanMainView.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica
import SwiftUI

struct ScanMainView: View {

    @EnvironmentObject private var appStore: AppStore

    private var device: Binding<Device?> {
        $appStore.appState.data.device
    }

    var body: some View {
        
        ScrollView {
            ScanStatusView()
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            ScanEntryView()

            ScanDeviceListView()
        }
        .navigationTitle("蓝牙扫描")
        .onAppear {
            appStore.dispatch(.status)
        }
        .toggle(DeviceType.isIphone || DeviceType.isIpad) {
            
            $0.platform(item: device) {  device in
                NavigationView { DeviceInfoEntryView() }
            }
        }
    }

}

extension ScanMainView {

    func test() {

    }
}

#Preview {
    ScanMainView().environmentObject(AppStore())
}
