//
//  CharacteristicState.swift
//  Bluetica
//
//  Created by Dream on 2025/9/30.
//


public enum CharacteristicState: String, @unchecked Sendable, CaseIterable, RawRepresentable, CustomStringConvertible {

    case unknown
    case broadcast
    case read
    case writeWithoutResponse
    case write
    case notify
    case indicate
    case authenticatedSignedWrites
    case extendedProperties
    case notifyEncryptionRequired
    case indicateEncryptionRequired
    public var description: String { "" }
    
}
