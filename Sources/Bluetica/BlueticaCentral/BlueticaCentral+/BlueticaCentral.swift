//
//  BlueticaCentral.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

final public class BlueticaCentral: NSObject, @unchecked Sendable {

    static let `default` = BlueticaCentral()

    var managerConfig = ConfigManager.default
    var centralConfig = ConfigCentral.default
    var peripheralConfig = ConfigPeripheral.default

    var centralHandler = HandlerCentral()
    var peripheralHandler = HandlerPeripheral()

    var peripherals = Peripherals()

    var isScanning = false
    
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

    private override init() {}
}
