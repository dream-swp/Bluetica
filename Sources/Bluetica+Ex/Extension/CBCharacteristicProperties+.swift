//
//  CBCharacteristicProperties+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/30.
//

import CoreBluetooth

/// CBCharacteristicProperties 扩展
/// 提供特征属性到自定义特征状态的转换
extension CBCharacteristicProperties {

    /// 转换为 CharacteristicState
    /// 根据特征属性返回对应的特征状态枚举
    public var convert: CharacteristicState {
        if self.contains(.broadcast) { return .broadcast }
        if self.contains(.read) { return .read }
        if self.contains(.write) { return .write }
        if self.contains(.writeWithoutResponse) { return .writeWithoutResponse }
        if self.contains(.notify) { return .notify }
        if self.contains(.indicate) { return .indicate }
        if self.contains(.authenticatedSignedWrites) { return .authenticatedSignedWrites }
        if self.contains(.extendedProperties) { return .extendedProperties }
        if self.contains(.notifyEncryptionRequired) { return .notifyEncryptionRequired }
        if self.contains(.indicateEncryptionRequired) { return .indicateEncryptionRequired }
        return .unknown

    }
}
