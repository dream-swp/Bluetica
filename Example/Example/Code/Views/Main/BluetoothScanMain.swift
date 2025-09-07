//
//  BluetoothScanMain.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//


import SwiftUI

import Bluetica

struct BluetoothScanMain: View {
    
    @EnvironmentObject private var appStore: AppStore
    
    @State var viewModel = BluetoothViewModel()
    var body: some View {
        ScrollView {
            BluetoothStatusCardView()
            
            BluetoothScanControlsView()
            
            BluetoothDeviceList()
        }
        .navigationTitle("蓝牙扫描")
        .onAppear {
            appStore.dispatch(.status)
        }
    }
    
}

extension BluetoothScanMain {
    
    func test() -> Void {
        
    }
}

#Preview {
    BluetoothScanMain().environmentObject(AppStore())
}
