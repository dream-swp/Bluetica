//
//  AppAction.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

protocol ActionProtocol { var command: AppCommand? { get } }

enum AppAction: ActionProtocol {

    case scan(ScanAction)
    case deviceInfo(DeviceInfoAction)

    case characteristics(CharacteristicsAction)

    var command: AppCommand? {
        switch self {
        case .scan(let value): value.command
        case .deviceInfo(let value): value.command
        case .characteristics(let value): value.command
        }
    }
}

extension AppAction {
    static var status: AppAction { .scan(.status) }
    static var start: AppAction { .scan(.start) }
    static var stop: AppAction { .scan(.stop) }
    static var scanDevice: AppAction { .scan(.scanDevice) }
    static var selectedDevice: (() -> (Device)) -> AppAction { return { .scan(.selectedDevice($0())) } }
    static var connectDevice: (() -> (Device)) -> AppAction { return { .scan(.connectDevice($0())) } }
    static var clearesDevice: AppAction { .scan(.clearesDevice) }
}

extension AppAction {}
