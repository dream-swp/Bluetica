//
//  Bluetica.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

/// Bluetica 蓝牙管理核心类，提供蓝牙中心设备的统一管理接口
/// 采用单例模式，支持 ObservableObject 用于 SwiftUI
final public class Bluetica: NSObject, ObservableObject, @unchecked Sendable {

    /// 单例实例
    public static let `default` = Bluetica()

    /// 蓝牙中心配置和状态管理
    var blueticaCentral = BlueticaCentral.default
    
    /// 扫描定时器，用于控制扫描时长
    var timer: Timer?

    /// CoreBluetooth 中心管理器
    var centralManager: CBCentralManager!
    

    // MARK: - private
    /// 私有初始化方法，确保单例模式
    private override init() {
        super.init()
        self.centralManager = blueticaCentral.centralManager { (delegate: self, isBackgroundMode: self.verify.isBackgroundMode) }
    }
    
    /// 析构时清理定时器资源
    deinit {
        timer?.invalidate()
    }

}


extension Bluetica {
    
    /// 开始扫描蓝牙外设
    /// - Note: 根据配置的扫描时长自动停止扫描
    func startScan() {
        if central.isEnabled == false { return }
        blueticaCentral.centralHandler.startDiscover?()
        centralManager.scanForPeripherals(withServices: blueticaCentral.centralConfig.services, options: blueticaCentral.centralConfig.scanOptions)
        switch blueticaCentral.centralConfig.scan {
        case .none: break
        case .time(let timeInterval):
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                self?.central.stop()
            }
        }
        blueticaCentral.isScanning = true
    }
    
    
    /// 停止扫描蓝牙外设
    /// - Parameter isRemove: 是否同时移除已发现的设备列表，默认 false
    /// - Returns: 返回自身以便链式调用
    func stopScan(_ isRemove: Bool = false) -> Self {
        timer?.invalidate()
        timer = nil
        if blueticaCentral.isScanning == false  { return self }
        centralManager.stopScan()
        blueticaCentral.isScanning = false
        if isRemove {
            blueticaCentral.peripherals.discover.removeAll()
        }
        blueticaCentral.centralHandler.stopDiscover?()
        return self
    }
    
}
