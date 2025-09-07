//
//  Array+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

// MARK: - [BlueticaCentral.Device]

extension [BlueticaCentral.Device] {
    
    mutating func append(to device: BlueticaCentral.Device) {
        if self.contains(device) { return }
        self.append(device)
    }
    
}
// MARK: -
