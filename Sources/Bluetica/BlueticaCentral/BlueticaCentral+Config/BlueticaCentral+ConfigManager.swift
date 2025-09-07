//
//  BlueticaCentral+ConfigManager.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.ManagerConfig
extension BlueticaCentral {

    public class ConfigManager: Config, @unchecked Sendable {

        static let `default` = ConfigManager()

        public var queue: dispatch_queue_t? = nil

        @BlueticaDefaultValue(ConfigManager.defaultOptions)
        public var options: [String: Any]?


        private init() {}

    }
}

extension BlueticaCentral.ConfigManager {
    static var defaultOptions: [String: Any] {
        [
            CBPeripheralManagerOptionRestoreIdentifierKey: Bundle.main.utils.identifier
        ]
    }
}

extension BlueticaCentral.ConfigManager {
    
    public func queue(_ handler: () -> (dispatch_queue_t)) -> Self {
        self.queue = handler()
        return self
    }
    
    
    public func options(_ handler: () -> ([String: Any]?)) -> Self {
        self.options = handler()
        return self
    }
    
}
// MARK: -
