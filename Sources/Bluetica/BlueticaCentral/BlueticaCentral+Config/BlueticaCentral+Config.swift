//
//  BlueticaCentral+Config.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

extension BlueticaCentral {
    protocol Config {
        static var defaultOptions: [String: Any] { get }
    }
}
