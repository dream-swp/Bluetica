//
//  BlueticaCentral.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

/// 蓝牙中心设备管理类
/// 管理蓝牙中心设备的配置、状态和外设连接
final public class BlueticaCentral: NSObject, @unchecked Sendable {

    /// 单例实例
    static let `default` = BlueticaCentral()

    /// 管理器配置
    var managerConfig = ConfigManager.default
    /// 中心设备配置
    var centralConfig = ConfigCentral.default
    /// 外设配置
    var peripheralConfig = ConfigPeripheral.default

    /// 中心设备事件处理器
    var centralHandler = HandlerCentral()
    /// 外设事件处理器
    var peripheralHandler = HandlerPeripheral()

    /// 外设管理容器
    var peripherals = Peripherals()

    /// 是否正在扫描
    var isScanning = false
    
    /// 中心管理器创建闭包
    /// 根据是否为后台模式创建对应的 CBCentralManager 实例
    var centralManager: (() -> (delegate: (any CBCentralManagerDelegate)?, isBackgroundMode: Bool?)) -> CBCentralManager {
        return { [weak self] in
            let result = $0()
            if let isBackgroundMode = result.isBackgroundMode, isBackgroundMode {
                return CBCentralManager(delegate: result.delegate, queue: self?.managerConfig.queue, options: self?.managerConfig.options)
            } else {
                return CBCentralManager(delegate: result.delegate, queue: self?.managerConfig.queue)
            }
        }
    }

    /// 私有初始化方法，确保单例模式
    private override init() {}
}
