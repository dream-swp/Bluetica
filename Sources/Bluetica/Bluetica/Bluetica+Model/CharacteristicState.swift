//
//  CharacteristicState.swift
//  Bluetica
//
//  Created by Dream on 2025/9/30.
//


/// 蓝牙特征值状态枚举，表示特征值支持的操作类型
public enum CharacteristicState: String, @unchecked Sendable, CaseIterable, RawRepresentable, CustomStringConvertible {

    /// 未知状态
    case unknown
    /// 支持广播
    case broadcast
    /// 支持读取
    case read
    /// 支持无响应写入
    case writeWithoutResponse
    /// 支持写入（需要响应）
    case write
    /// 支持通知
    case notify
    /// 支持指示
    case indicate
    /// 支持认证签名写入
    case authenticatedSignedWrites
    /// 支持扩展属性
    case extendedProperties
    /// 需要加密的通知
    case notifyEncryptionRequired
    /// 需要加密的指示
    case indicateEncryptionRequired
    
}
