//
//  BluetoothStatusCardStyle.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

import SwiftUI

struct BluetoothStatusCardStyle {

    var bluetoothIcon: BluetoothStyle
    let statusTitle: BluetoothStyle
    let infoIcon: BluetoothStyle
    let background: BluetoothStyle
    let textColor: BluetoothStyle
    let dividerColor: BluetoothStyle
    let success: BluetoothStyle
    let failure: BluetoothStyle

}

extension BluetoothStatusCardStyle {
    
    
    static var iconSuccess = BluetoothStyle.icon("dot.radiowaves.left.and.right")
    static var iconFailure = BluetoothStyle.icon("antenna.radiowaves.left.and.right.slash")

    static var statusCarStyle: Self {
        .init(
            bluetoothIcon: .icon("antenna.radiowaves.left.and.right.slash"),
            statusTitle: .text("蓝牙状态"),
            infoIcon: .icon("info.circle"),
            background: .color(.bluetoothCardBackground),
            textColor: .color(.bluetoothText),
            dividerColor: .colors([.clear, .bluetoothStatusCardDivider, .clear]),
            success: .color(.bluetoothStatusSuccess),
            failure: .color(.bluetoothStatusFailure)
        )

    }
}
