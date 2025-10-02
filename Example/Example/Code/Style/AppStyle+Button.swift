//
//  BluetoothScanButtonViewModel.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

import Foundation
import SwiftUI


struct AppButtonStyle {
    
    let start: AppButtonStyleType = .startStyle
    let stop: AppButtonStyleType = .stopStyle
    let clear: AppButtonStyleType = .clearStyle
    let connect: AppButtonStyleType = .connectStyle
    let deviceInfo: AppButtonStyleType = .infoStyle
    let deviceOperation: [AppButtonStyleType] = [.disconnectStyle, .subscribeStyle, .refreshFeatureStyle, .characteristicCountStyle]
}


struct AppButtonStyleType: Identifiable {

    let id = UUID()
    let imageName: AppStyleType 
    let title: AppStyleType
    let backgroundColor: AppStyleType
    let fontColor: AppStyleType
    let font: AppStyleType
    var disabled = false
    var cornerRadius: CGFloat = 10
    var execute: AppStyleType?

}

extension AppButtonStyleType {

    static var startStyle: Self {
        .init(imageName: .icon("play.circle.fill"), title: .text("开始扫描"), backgroundColor: .color(.blue), fontColor: .color(.white), font: .font(.callout))
    }

    static var stopStyle: Self {
        .init(imageName: .icon("stop.circle.fill"), title: .text("停止扫描"), backgroundColor: .color(.red), fontColor: .color(.white), font: .font(.callout))
    }

    static var clearStyle: Self {
        .init(imageName: .icon("trash"), title: .text("清空列表"), backgroundColor: .color(.orange), fontColor: .color(.white), font: .font(.callout))
    }
    
    static var connectStyle: Self {
        .init(imageName: .icon("link"), title: .text("连接设备"), backgroundColor: .color(.blue), fontColor: .color(.white), font: .font(.callout))
    }

    static var infoStyle: Self {
        .init(imageName: .icon("info.circle"), title: .text("查看详情"), backgroundColor: .color(.green), fontColor: .color(.white), font: .font(.callout))
    }

    static var disconnectStyle: Self {
        .init(imageName: .icon("link.circle"), title: .text("断开连接"), backgroundColor: .color(.red), fontColor: .color(.white), font: .font(.callout), execute: .command("disconnect"))
    }

    static var subscribeStyle: Self {
        .init(imageName: .icon("bell"), title: .text("订阅通知"), backgroundColor: .color(.orange), fontColor: .color(.white), font: .font(.callout), execute: .command("subscribe"))
    }

    static var refreshFeatureStyle: Self {
        .init(imageName: .icon("arrow.clockwise"), title: .text("刷新特征"), backgroundColor: .color(.green), fontColor: .color(.white), font: .font(.callout), execute: .command("refresh"))
    }

    static var characteristicCountStyle: Self {
        .init(imageName: .icon("info.circle"), title: .text("特征统计"), backgroundColor: .color(.purple), fontColor: .color(.white), font: .font(.callout), execute: .command("characteristic"))
    }

}
