//
//  BlueticaCentral+ConfigPeripheral.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.PeripheralConfig
extension BlueticaCentral {

    public class ConfigPeripheral: @unchecked Sendable {
        
        static let `default` = ConfigPeripheral()
        var services: [CBUUID]? = nil
        public var discoverServices: [CBUUID]? = nil
        public var discoverCharacteristics: [CBUUID]? = nil
        public var isDiscoverServices = true
        public var isDiscoverCharacteristics = true

        
        private init() { }
    }
}

extension BlueticaCentral.ConfigPeripheral {
    
    
    public func services(_ handler: () -> ([CBUUID]?)) -> Self {
        self.services = handler()
        return self
    }
    
    
    public func discoverServices(_ handler: () -> ([CBUUID]?)) -> Self {
        self.discoverServices = handler()
        return self
    }
    
    
    public func discoverCharacteristics(_ handler: () -> ([CBUUID]?)) -> Self {
        self.discoverCharacteristics = handler()
        return self
    }
}

// MARK: -
