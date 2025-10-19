//
//  CharacteristicsCommand.swift
//  Example
//
//  Created by Dream on 2025/10/3.
//

struct CharacteristicsSelectBarItemCommand: AppCommand {

    let item: CharacteristicBarItme

    func execute(_ store: AppStore, action: AppAction) {
        store.appState.appSignal.characteristicsBarItme = item
    }

}

struct CharacteristicsSelectCommand: AppCommand {

    let characteristic: Characteristic

    func execute(_ store: AppStore, action: AppAction) {
        store.appState.data.characteristic = characteristic
    }

    init(_ characteristic: Characteristic) {
        self.characteristic = characteristic
    }

}

struct CharacteristicsDefaultDataCommand: AppCommand {

    func execute(_ store: AppStore, action: AppAction) {
        store.appState.appSignal.characteristicsBarItme = .all

        if let characteristic = store.appState.data.characteristic, characteristic.isNotifying {
            store.dispatch(.deviceInfo(.unsubscribeNotify))
        }
        store.appState.data.characteristic = nil

    }

}
