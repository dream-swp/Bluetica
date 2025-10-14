//
//  Bluetica+Utils.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaUtils: Bundle
/// Bundle 桥接（资源扩展）
extension Bundle: Utils {}

extension BlueticaUtils where Utils == Bundle {

    var backgroundModes: [String] {
        guard let backgroundModes = Bundle.main.infoDictionary?["UIBackgroundModes"] as? [String] else {
            return []
        }
        return backgroundModes
    }

    static var defaultIdentifier: String { "com.dream.ds.bluetica" }

    var defaultIdentifier: String { Self.defaultIdentifier }

    var identifier: String { Bundle.main.bundleIdentifier ?? self.defaultIdentifier }

    static var identifier: String { Bundle.main.bundleIdentifier ?? Self.defaultIdentifier }

}

// MARK: - BlueticaUtils: String
extension String: Utils { }

extension BlueticaUtils where Utils == String {
    
    var trim: String {
        self.utils.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: -
