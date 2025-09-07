//
//  AppCommand.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

protocol AppCommand {
    func execute(in store: AppStore)
}

protocol AppUpdateData {
    var update: (() -> (AppState)) -> AppState { get }
}
