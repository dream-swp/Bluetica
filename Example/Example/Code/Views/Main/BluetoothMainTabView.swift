//
//  MainTabView.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import SwiftUI

struct BluetoothMainTabView: View {
    var body: some View {
        BluetoothMainBarView.mainBarView
    }
}

#Preview {
    BluetoothMainTabView().environmentObject(AppStore())
}
