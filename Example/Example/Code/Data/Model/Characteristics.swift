//
//  Characteristics.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import Foundation
import CoreBluetooth
import Bluetica


struct Characteristics {
    
    let service: BlueticaCentral.Service
    let characteristic: BlueticaCentral.Characteristic
    
}

extension Characteristics: Identifiable {
    var id: CBUUID { characteristic.uuid }
    var name: String { characteristic.uuid.string }
    var status: CharacteristicState { characteristic.status }
    
    var properties: CBCharacteristicProperties { characteristic.properties } 
}
