//
//  CharacteristicsSideBarItme.swift
//  Example
//
//  Created by Dream on 2025/10/2.
//


enum CharacteristicsSideBarItme: String, CaseIterable, Identifiable {
    
    var id: Self { self }

    case all = "全部"
    case read = "可读"
    case write = "可写"
    case notify = "可通知"
    
    func matches() -> Bool {
        true
    }
    
    func matches(_ characteristic: Characteristics) -> Bool {
        
        switch self {
        case .all:
            return true
        case .read:
//            return characteristic.properties.contains(.read)
            return characteristic.status == .read
        case .write:
//            return characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)
            return characteristic.status == .write || characteristic.status == .writeWithoutResponse
        case .notify:
//            return characteristic.characteristic.properties.contains(.notify) || characteristic.characteristic.properties.contains(.indicate)
            return characteristic.status == .notify || characteristic.status == .indicate
        }
    }

    var count:(() -> ([Characteristics])) -> Int {
        return { result in
            result().filter { self.matches($0) }.count
        }
    }
    
}
