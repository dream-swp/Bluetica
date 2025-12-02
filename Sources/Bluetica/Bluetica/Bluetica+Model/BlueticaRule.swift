//
//  BlueticaScanType.swift
//  Bluetica
//
//  Created by Dream on 2025/9/6.
//

import Foundation

/// Bluetica 规则协议，用于标记各种规则类型
public protocol BlueticaRule { }

/// 蓝牙扫描规则
public enum BlueticaScanRule {
    
    /// 无限扫描，直到手动停止
    case none
    /// 定时扫描，超时后自动停止
    /// - Parameter TimeInterval: 扫描时长（秒）
    case time(TimeInterval)
}

/// 蓝牙设备过滤规则
public enum BlueticaFilterRule {
    
    /// 无过滤，显示所有设备
    case none
    /// 按设备名称过滤，仅显示 name 不为 nil 的设备
    case name
    
    /// 按标识符过滤，仅显示 name 不为 nil 且 identifier 唯一的设备
    case identifier
    
    /// 自定义过滤规则
    /// - Parameter Bool: 是否过滤掉该设备
    case custom(Bool)
}



