//
//  AppStore.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica
import Foundation

class AppStore: ObservableObject {
    @Published var appState = AppState()
}

extension AppStore {


    func dispatch(_ action: AppAction) {

        #if DEBUG
            print("[ACTION]: \(action)")
        #endif

        // new value
        let result = Self.reduce(state: appState, action: action)

        // set value
        appState = result.state

        guard let command = result.command else {
            return
        }

        #if DEBUG
            print("[COMMAND]: \(command)")
        #endif

        command.execute(self, action: action)
    }

}

extension AppStore {

    static func reduce(state aState: AppState, action: AppAction) -> (state: AppState, command: AppCommand?) {

        var state = aState

        let command = action.command
        
        if let command = command as? AppUpdateData {
            state = command.update { ( state, action) }
        }

        return (state, command)
    }

}
