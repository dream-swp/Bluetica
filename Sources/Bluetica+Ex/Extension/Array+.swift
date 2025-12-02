//
//  Array+.swift
//  Bluetica
//
//  Created by Dream on 2025/9/4.
//

import Foundation

// MARK: - [BlueticaCentral.Device]

/// BlueticaCentral.Device 数组扩展
/// 提供设备列表的便捷操作方法
extension [BlueticaCentral.Device] {

    /// 添加设备到数组（去重）
    /// 仅当设备不为 nil 且不存在于数组中时才添加
    /// - Parameter device: 要添加的设备对象
    mutating func append(to device: BlueticaCentral.Device?) {
        guard let device = device, self.contains(device) == false else { return }
        self.append(device)
    }

    /// 根据 UUID 查找设备的闭包
    /// - Returns: 接受 UUID 闭包并返回匹配设备的闭包
    var device: (() -> (UUID)) -> BlueticaCentral.Device? {
        return {
            let identifier = $0()
            return self.first(where: { $0.identifier == identifier })
        }
    }

    /// 替换数组中的设备
    /// 如果设备存在于数组中，则用新设备替换
    /// - Parameter handler: 返回要替换的设备的闭包
    /// - Returns: 更新后的数组
    mutating func replace(_ handler: () -> (BlueticaCentral.Device?)) -> Self {
        guard let device = handler() else { return self }
        let _ = self.firstIndex(of: device).map { self[$0] = device }
        return self
    }

}
// MARK: -
