//
//  BluetoothStatusCardStyle.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

import SwiftUI

struct ScanStatusStyle {
    
    let success: ScanStatusStyleType = .success
    let failure: ScanStatusStyleType = .failure
    
}

struct ScanStatusStyleType {

    var bluetoothIcon: AppStyleType
    let statusTitle: AppStyleType
    let infoIcon: AppStyleType
    let background: AppStyleType
    let textColor: AppStyleType
    let dividerColor: AppStyleType
    let foregroundStyle: AppStyleType
}

extension ScanStatusStyleType {
    
    static var success: Self {
        .init(
            bluetoothIcon: .icon("personalhotspot"),
            statusTitle: .text("蓝牙状态"),
            infoIcon: .icon("info.circle"),
            background: .color(.bluetoothCardBackground),
            textColor: .color(.bluetoothText),
            dividerColor: .colors([.clear, .bluetoothStatusCardDivider, .clear]),
            foregroundStyle: .color(.bluetoothStatusSuccess),
        )

    }
    
    
    static var failure: Self {
        .init(
            bluetoothIcon: .icon("personalhotspot.slash"),
            statusTitle: .text("蓝牙状态"),
            infoIcon: .icon("info.circle"),
            background: .color(.bluetoothCardBackground),
            textColor: .color(.bluetoothText),
            dividerColor: .colors([.clear, .bluetoothStatusCardDivider, .clear]),
            foregroundStyle: .color(.bluetoothStatusFailure)
        )

    }
}
