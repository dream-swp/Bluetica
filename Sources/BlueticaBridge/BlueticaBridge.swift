//
//  BlueticaBridge.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import Foundation

import CoreBluetooth

/// Bluetica 桥接协议，标记可桥接类型，便于统一扩展
public protocol BlueticaBridge { }

/// Bluetica 主类型桥接
extension Bluetica: BlueticaBridge { }

/// BlueticaCentral 中心桥接
extension BlueticaCentral.Central: BlueticaBridge { }

/// Bluetica 外设桥接
extension BlueticaPeripheral: BlueticaBridge { }






