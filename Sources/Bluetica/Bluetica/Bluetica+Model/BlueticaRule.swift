//
//  BlueticaScanType.swift
//  Bluetica
//
//  Created by Dream on 2025/9/6.
//

import Foundation

import Foundation

public protocol BlueticaRule { }

public enum BlueticaScanRule {
    
    case none
    case time(TimeInterval)
}

public enum BlueticaFilterRule {
    
    case none
    // name != nil
    case name
    
    // name != nil, and identifier only one
    case identifier
    
    case custom(Bool)
}



