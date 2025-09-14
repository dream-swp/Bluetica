//
//  BluetoothScanButtonViewModel.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

import SwiftUI

struct BluetoothButtonStyle {

    let imageName: BluetoothStyle
    let title: BluetoothStyle
    let backgroundColor: BluetoothStyle
    let fontColor: BluetoothStyle
    let font: BluetoothStyle
    var disabled = false
    var cornerRadius: CGFloat = 10

}

extension BluetoothButtonStyle {

    static var startStyle: Self {

        .init(
            imageName: .icon("play.circle.fill"),
            title: .text("开始扫描"),
            backgroundColor: .color(.blue),
            fontColor: .color(.white),
            font: .font(.callout)
        )
    }

    static var stopStyle: Self {
        .init(
            imageName: .icon("stop.circle.fill"),
            title: .text("停止扫描"),
            backgroundColor: .color(.red),
            fontColor: .color(.white),
            font: .font(.callout)
        )
    }

    static var clearStyle: Self {
        .init(
            imageName: .icon("trash"),
            title: .text("清空列表"),
            backgroundColor: .color(.orange),
            fontColor: .color(.white),
            font: .font(.callout))
    }

}
