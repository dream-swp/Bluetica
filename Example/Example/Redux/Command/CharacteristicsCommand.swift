//
//  CharacteristicsCommand.swift
//  Example
//
//  Created by Dream on 2025/10/3.
//



struct CharacteristicsSelectBarItemCommand: AppCommand {
    
    let item: CharacteristicsBarItme
    
    func execute(_ store: AppStore, action: AppAction) {
        store.appState.appSignal.characteristicsBarItme = item
    }
    
}

struct CharacteristicsSelectCommand: AppCommand {
    
    let characteristic: Characteristics
    
    func execute(_ store: AppStore, action: AppAction) {
        store.appState.data.characteristic = characteristic
    }

    init(_ characteristic: Characteristics) {
        self.characteristic = characteristic
    }
    
}

struct CharacteristicsDefaultDataCommand: AppCommand {
    
    func execute(_ store: AppStore, action: AppAction) {
        store.appState.appSignal.characteristicsBarItme = .all
        store.appState.data.characteristic = nil
    }
    
}
