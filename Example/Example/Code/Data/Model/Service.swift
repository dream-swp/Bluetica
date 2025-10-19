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

    init(_ service: BlueticaCentral.Service) {
        self.service = service
    }
}

extension Service: Identifiable {
    var id: UUID { service.id }

}

extension Service {

    var uuid: CBUUID { service.uuid }

    var characteristic: [Characteristic] {
        service.serviceCharacteristics.compactMap { Characteristic(service: Service($0.service), characteristic: $0.characteristic) }
    }

    var isPrimary: Bool { service.isPrimary }
    
}
