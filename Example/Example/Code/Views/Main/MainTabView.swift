//
//  MainTabView.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//


import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                BluetoothScanMain()
            }
#if os(macOS)
            .frame(minWidth: 900, idealWidth: 1100, maxWidth: 1300, minHeight: 700, idealHeight: 900, maxHeight: 1100)
#endif
            .tabItem {
                Image(systemName: "antenna.radiowaves.left.and.right")
                Text("蓝牙扫描")
            }
        }
    }
}


#Preview {
    MainTabView().environmentObject(AppStore())
}
