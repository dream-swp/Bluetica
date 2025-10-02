//
//  Service.swift
//  Example
//
//  Created by Dream on 2025/9/22.
//

import Bluetica
import CoreBluetooth
import Foundation

struct Service {
    let service: BlueticaCentral.Service
}

extension Service: Identifiable {
    var id: UUID { service.id }
    var uuid: CBUUID { service.uuid }
    var characteristic: [Characteristics] {
        service.serviceCharacteristics.compactMap { Characteristics(service: $0.service, characteristic: $0.characteristic) }
    }
    var isPrimary: Bool { service.isPrimary }
}





