//
//  BlueticaCentral+Peripherals.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//


import CoreBluetooth

// MARK: - BlueticaCentral.Peripherals
extension BlueticaCentral {
    struct Peripherals {
        var device: Device?
        var peripheral: CBPeripheral?
        var discover: [Device] = []
        var connected: [Device] = []
    }
}

extension BlueticaCentral.Peripherals {
    
    mutating func updateDiscover(_ handler: () ->  (CBPeripheral)) -> Self {
        let peripheral = handler()
        let device = self.discover.device { peripheral.identifier }
        
        self.device = device
        self.peripheral = peripheral
        let _ =  self.discover.replace { device }
        
        return self
    }
    
    mutating func updateConnected(_ handler: () ->  (CBPeripheral)) -> Self {
        let peripheral = handler()
        let  device = self.connected.device { peripheral.identifier }
        
        self.device = device
        self.peripheral = peripheral
        let _ = self.connected.replace { device }
        
        return self
    }
}
// MARK: -
