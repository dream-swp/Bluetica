//
//  Array+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

import Foundation

// MARK: - [BlueticaCentral.Device]

extension [BlueticaCentral.Device] {

    mutating func append(to device: BlueticaCentral.Device?) {
        guard let device = device, self.contains(device) == false else { return }
        self.append(device)
    }

    var device: (() -> (UUID)) -> BlueticaCentral.Device? {
        return {
            let identifier = $0()
            return self.first(where: { $0.identifier == identifier })
        }
    }

    mutating func replace(_ handler: () -> (BlueticaCentral.Device?)) -> Self {
        guard let device = handler() else { return self }
        let _ = self.firstIndex(of: device).map { self[$0] = device }
        return self
    }

}
// MARK: -
