//
//  AppCommand.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//


protocol AppCommand {
    func execute(_ store: AppStore, action: AppAction)
}

protocol AppUpdateData {
    var update: (() -> (state: AppState, action: AppAction)) -> AppState { get }
}
