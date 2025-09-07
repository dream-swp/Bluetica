//
//  BlueticaCentral+ConfigCentral.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.CentralConfig
extension BlueticaCentral {

    public class ConfigCentral: Config, @unchecked Sendable {

        static let `default` = ConfigCentral()
        
        public var services: [CBUUID]? = nil

        @BlueticaDefaultValue(ConfigCentral.defaultOptions)
        public var scanOptions: [String: Any]?

        public var connectOptions: [String: Any]? = nil

        public var scan: BlueticaScanRule = .none

        public var filter: BlueticaFilterRule = .identifier
        
        private init() { }
    }
}

extension BlueticaCentral.ConfigCentral {

    static var defaultOptions: [String: Any] {
        [
            CBCentralManagerScanOptionAllowDuplicatesKey: true
        ]
    }
}

extension BlueticaCentral.ConfigCentral {

    public func services(_ handler: () -> ([CBUUID]?)) -> Self {
        self.services = handler()
        return self

    }

    public func scanOptions(_ handler: () -> ([String: Any]?)) -> Self {
        self.scanOptions = handler()
        return self

    }

    public func connectOptions(_ handler: () -> ([String: Any]?)) -> Self {
        self.connectOptions = handler()
        return self

    }

    public func scan(_ handler: () -> (BlueticaScanRule)) -> Self {
        self.scan = handler()
        return self

    }

    public func filter(_ handler: () -> (BlueticaFilterRule)) -> Self {
        self.filter = handler()
        return self
    }
}

// MARK: -
