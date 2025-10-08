//
//  CharacteristicsInfoAction.swift
//  Example
//
//  Created by Dream on 2025/10/3.
//

enum CharacteristicsAction: ActionProtocol {

    case characteristicsSelectBarItme(CharacteristicsBarItme)

    case characteristicsSelect(Characteristics)
    
    case characteristicsDefaultData

    var command: (AppCommand)? {
        switch self {
        case .characteristicsSelectBarItme(let item):
            CharacteristicsSelectBarItemCommand(item: item)
        case .characteristicsSelect(let characteristics):
            CharacteristicsSelectCommand(characteristics)
        case .characteristicsDefaultData:
            CharacteristicsDefaultDataCommand()
        }
    }
}
