//
//  DeviceType.swift
//  Example
//
//  Created by Dream on 2025/9/10.
//

#if canImport(UIKit)
    import UIKit
#endif

#if canImport(AppKit)
    import AppKit
#endif

#if canImport(WatchKit)
    import WatchKit
#endif

// 设备类型枚举
enum DeviceType {
    case mac
    case ipad
    case iphone
    case tv
    case watch
    case unknown

    static var device: Self {

        #if targetEnvironment(macCatalyst)
            return .mac
        #elseif os(macOS)
            return .mac
        #elseif os(tvOS)
            return .tv
        #elseif os(watchOS)
            return .watch
        #elseif os(iOS)
            switch UIDevice.current.userInterfaceIdiom {
            case .phone: return .iphone
            case .pad: return .ipad
            case .tv: return .tv
            default: return .unknown
            }
        #else
            .unknown
        #endif

    }
    
    var device: Self { DeviceType.device }

    static var deviceInfo: String {
        var info = ""

        #if targetEnvironment(macCatalyst)
            info += "运行在 Mac Catalyst 上\n"
        #elseif os(macOS)
            info += "运行在原生 macOS 上\n"
            // 获取 macOS 特定信息
            let processInfo = ProcessInfo.processInfo
            info += "主机名: \(processInfo.hostName)\n"
            info += "操作系统版本: \(processInfo.operatingSystemVersionString)\n"
        #elseif os(tvOS)
            // tvOS 特定信息
            info += "设备类型: Apple TV\n"

            // 获取 tvOS 特定信息
            let device = UIDevice.current
            info += "系统名称: \(device.systemName)\n"
            info += "系统版本: \(device.systemVersion)\n"

            let screen = UIScreen.main
            info += "屏幕尺寸: \(screen.bounds.size)\n"
        #elseif os(watchOS)
            // watchOS 使用 WKInterfaceDevice

            let device = WKInterfaceDevice.current()
            info += "设备模型: Apple Watch\n"
            info += "系统名称: watchOS\n"
            info += "系统版本: \(device.systemVersion)\n"
            info += "屏幕尺寸: \(device.screenBounds.size)\n"
            info += "预置内容尺寸: \(device.preferredContentSizeCategory.rawValue)\n"
        #elseif os(iOS)
            // iOS/iPadOS 使用 UIDevice
            let device = UIDevice.current
            info += "设备模型: \(device.model)\n"
            info += "系统名称: \(device.systemName)\n"
            info += "系统版本: \(device.systemVersion)\n"
            info += "物理设备: \(device.name)\n"
        #else
            info += "未知平台\n"
        #endif
        return info
    }
    
    var deviceInfo: String { DeviceType.deviceInfo }
    
    static var isMac: Bool { device == .mac }
    static var isIphone: Bool { device == .iphone }
    static var isIpad: Bool { device == .ipad }
    static var isWatch: Bool { device == .watch }
    static var isTV: Bool { device == .tv }
    
    var isMac: Bool { device == .mac }
    var isIphone: Bool { device == .iphone }
    var isIpad: Bool { device == .ipad }
    var isWatch: Bool { device == .watch }
    var isTV: Bool { device == .tv }
}
