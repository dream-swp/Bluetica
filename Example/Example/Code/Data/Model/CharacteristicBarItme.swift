//
//  CharacteristicsSideBarItme.swift
//  Example
//
//  Created by Dream on 2025/10/2.
//

enum CharacteristicBarItme: String, CaseIterable, Identifiable {

    var id: Self { self }

    case all = "全部"
    case read = "可读"
    case write = "可写"
    case notify = "可通知"

    func matches() -> Bool {
        true
    }

    func matches(_ characteristic: Characteristic) -> Bool {
        switch self {
        case .all: return true
        case .read: return characteristic.isRead
        case .write: return characteristic.isWriteResponse || characteristic.isWriteWithoutResponse
        case .notify: return characteristic.isNotify || characteristic.isIndicate
        }
    }

    var count: (() -> ([Characteristic])) -> Int {
        return { result in
            result().filter { self.matches($0) }.count
        }
    }

    func datas(_ handler: () -> [Characteristic]) -> [(service: String, characteristics: [Characteristic])] {

        let result = handler()
        let filter = result.filter { self.matches($0) }
        let grouped = Dictionary(grouping: filter) { $0.service.uuid.string }
        
        let datas = grouped.compactMap { (key: String, value: [Characteristic]) in
            (service: key, characteristics: value.sorted { $0.name < $1.name })
        }.sorted { $0.service < $1.service }
        
        return datas
    }

}
