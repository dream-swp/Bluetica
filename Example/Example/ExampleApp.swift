//
//  ExampleApp.swift
//  Example
//
//  Created by Dream on 2025/5/18.
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            BluetoothMainTabView().environmentObject(AppStore())
        }
    }
}


