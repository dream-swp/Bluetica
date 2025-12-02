//
//  BlueticaCentral+HandlerPeripheral.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//


// MARK: - BlueticaCentral.PeripheralHandler
extension BlueticaCentral {
    /// 蓝牙外设事件处理器，集中存储所有外设相关回调
    struct HandlerPeripheral {
        /// 外设名称更新回调
        var updateName: Handler.UpdateName? = nil
        /// 服务变更回调
        var modifyServices: Handler.ModifyServices? = nil
        /// RSSI 更新回调
        var updateRSSI: Handler.UpdateRSSI? = nil
        /// 读取 RSSI 回调
        var readRSSI: Handler.ReadRSSI? = nil
        /// 服务发现回调
        var discoverServices: Handler.DiscoverServices? = nil
        /// 包含服务发现回调
        var discoverIncludedServices: Handler.DiscoverIncludedServices? = nil
        /// 特征值发现回调
        var discoverCharacteristics: Handler.DiscoverCharacteristics? = nil
        /// 特征值更新回调
        var updateValue: Handler.UpdateValue? = nil
        /// 写入特征值回调
        var writeValue: Handler.WriteValue? = nil
        /// 通知状态更新回调
        var updateNotificationState: Handler.UpdateNotificationState? = nil
        /// 描述符发现回调
        var discoverDescriptors: Handler.DiscoverDescriptors? = nil
        /// 描述符值更新回调
        var updateValueDescriptor: Handler.UpdateValueDescriptor? = nil
        /// 写入描述符值回调
        var writeValueDescriptor: Handler.WriteValueDescriptor? = nil
        /// 无响应写入回调
        var sendWriteWithoutResponse: Handler.SendWriteWithoutResponse? = nil
        /// 打开 L2CAP 信道回调
        var openChannel: Handler.OpenChannel? = nil
    }
}
// MARK: -
