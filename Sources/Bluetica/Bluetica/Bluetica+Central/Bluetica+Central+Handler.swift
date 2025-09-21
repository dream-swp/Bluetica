//
//  Bluetica+Central+Handler.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//

import CoreBluetooth
import Foundation

/// BlueticaCentral.Central 的扩展，提供中心相关事件处理的链式接口
extension BlueticaCentral.Central where Central == Bluetica {

    /// 设置开始扫描回调
    /// - Parameter handler: 发现开始回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    func startDiscover(_ handler: @escaping BlueticaCentral.Handler.DiscoverStart) -> Self {
        central.blueticaCentral.centralHandler.startDiscover = handler
        return self
    }

    /// 设置开始扫描回调（链式）
    public var startDiscover: BlueticaCentral.Handler.DiscoverStartResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.startDiscover = $0
            return Bluetica.default.central
        }
    }

    /// 设置停止扫描回调
    /// - Parameter handler: 发现停止回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    func stopDiscover(_ handler: @escaping BlueticaCentral.Handler.DiscoverStop) -> Self {
        central.blueticaCentral.centralHandler.stopDiscover = handler
        return self
    }

    /// 设置停止扫描回调（链式）
    public var stopDiscover: BlueticaCentral.Handler.DiscoverStopResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.stopDiscover = $0
            return Bluetica.default.central
        }
    }

    /// 设置中心状态恢复回调
    /// - Parameter handler: 状态恢复回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func restoreState(_ handler: @escaping BlueticaCentral.Handler.RestoreState) -> Self {
        central.blueticaCentral.centralHandler.restoreState = handler
        return self
    }

    /// 设置中心状态恢复回调（链式）
    public var restoreState: BlueticaCentral.Handler.RestoreStateResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.restoreState = $0
            return Bluetica.default.central
        }
    }

    /// 设置中心状态更新回调
    /// - Parameter handler: 状态更新回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func updateState(_ handler: @escaping BlueticaCentral.Handler.UpdateState) -> Self {
        central.blueticaCentral.centralHandler.state = handler
        return self
    }

    /// 设置中心状态更新回调（链式）
    public var updateState: BlueticaCentral.Handler.UpdateStateResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.state = $0
            return Bluetica.default.central
        }
    }

    /// 设置扫描结果更新回调
    /// - Parameter handler: 发现结果更新回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func updateDiscover(_ handler: @escaping BlueticaCentral.Handler.UpdateDiscover) -> Self {
        central.blueticaCentral.centralHandler.updateDiscover = handler
        return self
    }

    /// 设置扫描结果更新回调（链式）
    public var updateDiscover: BlueticaCentral.Handler.UpdateDiscoverResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.updateDiscover = $0
            return Bluetica.default.central
        }
    }

    /// 设置发现设备回调
    /// - Parameter handler: 发现设备回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func discover(_ handler: @escaping BlueticaCentral.Handler.Discover) -> Self {
        central.blueticaCentral.centralHandler.discover = handler
        return self
    }

    /// 设置发现设备回调（链式）
    public var discover: BlueticaCentral.Handler.DiscoverResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.discover = $0
            return Bluetica.default.central
        }
    }

    /// 设置连接成功回调
    /// - Parameter handler: 连接成功回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    func connectSuccess(_ handler: @escaping BlueticaCentral.Handler.SuccessConnect) -> Self {
        central.blueticaCentral.centralHandler.connectSuccess = handler
        return self
    }

    /// 设置连接成功回调（链式）
    public var connectSuccess: BlueticaCentral.Handler.SuccessConnectResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.connectSuccess = $0
            return Bluetica.default.central
        }
    }

    /// 设置连接失败回调
    /// - Parameter handler: 连接失败回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func connectFailure(_ handler: @escaping BlueticaCentral.Handler.FailConnect) -> Self {
        central.blueticaCentral.centralHandler.connectFailure = handler
        return self
    }

    /// 设置连接失败回调（链式）
    public var connectFailure: BlueticaCentral.Handler.FailConnectResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.connectFailure = $0
            return Bluetica.default.central
        }
    }

    /// 设置外设断开回调
    /// - Parameter handler: 外设断开回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    public func disconnectPeripheral(_ handler: @escaping BlueticaCentral.Handler.DisconnectPeripheral) -> Self {
        central.blueticaCentral.centralHandler.disconnectPeripheral = handler
        return self
    }

    /// 设置外设断开回调（链式）
    public var disconnectPeripheral: BlueticaCentral.Handler.DisconnectPeripheralResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.disconnectPeripheral = $0
            return Bluetica.default.central
        }
    }

    /// 设置外设断开时间戳回调
    /// - Parameter handler: 外设断开时间戳回调
    /// - Returns: 返回自身以便链式调用
    @discardableResult
    func disconnectPeripheralTimestamp(_ handler: @escaping BlueticaCentral.Handler.DisconnectPeripheralTimestamp) -> Self {
        central.blueticaCentral.centralHandler.disconnectPeripheralTimestamp = handler
        return self
    }

    /// 设置外设断开时间戳回调（链式）
    public var disconnectPeripheralTimestamp: BlueticaCentral.Handler.DisconnectPeripheralTimestampResult {
        return { [weak central] in
            central?.blueticaCentral.centralHandler.disconnectPeripheralTimestamp = $0
            return Bluetica.default.central
        }
    }

    #if os(iOS)

        /// 设置连接事件回调（仅 iOS）
        /// - Parameter handler: 连接事件回调
        /// - Returns: 返回自身以便链式调用
        @discardableResult
        func connectionEvent(_ handler: @escaping BlueticaCentral.Handler.ConnectionEvent) -> Self {
            central.blueticaCentral.centralHandler.connectionEvent = handler
            return self
        }

        /// 设置连接事件回调（链式，仅 iOS）
        public var connectionEvent: BlueticaCentral.Handler.ConnectionEventResult {
            return { [weak central] in
                central?.blueticaCentral.centralHandler.connectionEvent = $0
                return Bluetica.default.central
            }
        }

        /// 设置 ANCS 授权状态更新回调（仅 iOS）
        /// - Parameter handler: 授权状态更新回调
        /// - Returns: 返回自身以便链式调用
        @discardableResult
        func updateANCSAuthorization(_ handler: @escaping BlueticaCentral.Handler.UpdateANCSAuthorization) -> Self {
            central.blueticaCentral.centralHandler.updateANCSAuthorization = handler
            return self
        }

        /// 设置 ANCS 授权状态更新回调（链式，仅 iOS）
        public var updateANCSAuthorization: BlueticaCentral.Handler.UpdateANCSAuthorizationResult {
            return { [weak central] in
                central?.blueticaCentral.centralHandler.updateANCSAuthorization = $0
                return Bluetica.default.central
            }
        }

    #endif

}

extension BlueticaCentral.Central where Central == Bluetica {
    /// 设置外设名称更新回调
    /// - Parameter handler: 名称更新事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func updateName(_ handler: @escaping BlueticaCentral.Handler.UpdateName) -> Self {
        central.blueticaCentral.peripheralHandler.updateName = handler
        return self
    }

    /// 链式设置外设名称更新回调
    public var updateName: BlueticaCentral.Handler.UpdateNameResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.updateName = $0
            return Bluetica.default.central
        }
    }

    /// 设置服务变更回调
    /// - Parameter handler: 服务变更事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func modifyServices(_ handler: @escaping BlueticaCentral.Handler.ModifyServices) -> Self {
        central.blueticaCentral.peripheralHandler.modifyServices = handler
        return self
    }

    /// 链式设置服务变更回调
    public var modifyServices: BlueticaCentral.Handler.ModifyServicesResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.modifyServices = $0
            return Bluetica.default.central
        }
    }

    /// 设置 RSSI 更新回调
    /// - Parameter handler: RSSI 更新事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func updateRSSI(_ handler: @escaping BlueticaCentral.Handler.UpdateRSSI) -> Self {
        central.blueticaCentral.peripheralHandler.updateRSSI = handler
        return self
    }

    /// 链式设置 RSSI 更新回调
    public var updateRSSI: BlueticaCentral.Handler.UpdateRSSIResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.updateRSSI = $0
            return Bluetica.default.central
        }
    }

    /// 设置读取 RSSI 回调
    /// - Parameter handler: 读取 RSSI 事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func readRSSI(_ handler: @escaping BlueticaCentral.Handler.ReadRSSI) -> Self {
        central.blueticaCentral.peripheralHandler.readRSSI = handler
        return self
    }

    /// 链式设置读取 RSSI 回调
    public var readRSSI: BlueticaCentral.Handler.ReadRSSIResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.readRSSI = $0
            return Bluetica.default.central
        }
    }

    /// 设置服务发现回调
    /// - Parameter handler: 服务发现事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func discoverServices(_ handler: @escaping BlueticaCentral.Handler.DiscoverServices) -> Self {
        central.blueticaCentral.peripheralHandler.discoverServices = handler
        return self
    }

    /// 链式设置服务发现回调
    public var discoverServices: BlueticaCentral.Handler.DiscoverServicesResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.discoverServices = $0
            return Bluetica.default.central
        }
    }

    /// 设置包含服务发现回调
    /// - Parameter handler: 包含服务发现事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func discoverIncludedServices(_ handler: @escaping BlueticaCentral.Handler.DiscoverIncludedServices) -> Self {
        central.blueticaCentral.peripheralHandler.discoverIncludedServices = handler
        return self
    }

    /// 链式设置包含服务发现回调
    public var discoverIncludedServices: BlueticaCentral.Handler.DiscoverIncludedServicesResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.discoverIncludedServices = $0
            return Bluetica.default.central
        }
    }

    /// 设置特征值发现回调
    /// - Parameter handler: 特征值发现事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func discoverCharacteristics(_ handler: @escaping BlueticaCentral.Handler.DiscoverCharacteristics) -> Self {
        central.blueticaCentral.peripheralHandler.discoverCharacteristics = handler
        return self
    }

    /// 链式设置特征值发现回调
    public var discoverCharacteristics: BlueticaCentral.Handler.DiscoverCharacteristicsResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.discoverCharacteristics = $0
            return Bluetica.default.central
        }
    }

    /// 设置特征值更新回调
    /// - Parameter handler: 特征值更新事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func updateValue(_ handler: @escaping BlueticaCentral.Handler.UpdateValue) -> Self {
        central.blueticaCentral.peripheralHandler.updateValue = handler
        return self
    }

    /// 链式设置特征值更新回调
    public var updateValue: BlueticaCentral.Handler.UpdateValueResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.updateValue = $0
            return Bluetica.default.central
        }
    }

    /// 设置写入特征值回调
    /// - Parameter handler: 写入特征值事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func writeValue(_ handler: @escaping BlueticaCentral.Handler.WriteValue) -> Self {
        central.blueticaCentral.peripheralHandler.writeValue = handler
        return self
    }

    /// 链式设置写入特征值回调
    public var writeValue: BlueticaCentral.Handler.WriteValueResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.writeValue = $0
            return Bluetica.default.central
        }
    }

    /// 设置通知状态更新回调
    /// - Parameter handler: 通知状态更新事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func updateNotificationState(_ handler: @escaping BlueticaCentral.Handler.UpdateNotificationState) -> Self {
        central.blueticaCentral.peripheralHandler.updateNotificationState = handler
        return self
    }

    /// 链式设置通知状态更新回调
    public var updateNotificationState: BlueticaCentral.Handler.UpdateNotificationStateResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.updateNotificationState = $0
            return Bluetica.default.central
        }
    }

    /// 设置描述符发现回调
    /// - Parameter handler: 描述符发现事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func discoverDescriptors(_ handler: @escaping BlueticaCentral.Handler.DiscoverDescriptors) -> Self {
        central.blueticaCentral.peripheralHandler.discoverDescriptors = handler
        return self
    }

    /// 链式设置描述符发现回调
    public var discoverDescriptors: BlueticaCentral.Handler.DiscoverDescriptorsResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.discoverDescriptors = $0
            return Bluetica.default.central
        }
    }

    /// 设置描述符值更新回调
    /// - Parameter handler: 描述符值更新事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func updateValueDescriptor(_ handler: @escaping BlueticaCentral.Handler.UpdateValueDescriptor) -> Self {
        central.blueticaCentral.peripheralHandler.updateValueDescriptor = handler
        return self
    }

    /// 链式设置描述符值更新回调
    public var updateValueDescriptor: BlueticaCentral.Handler.UpdateValueDescriptorResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.updateValueDescriptor = $0
            return Bluetica.default.central
        }
    }

    /// 设置写入描述符值回调
    /// - Parameter handler: 写入描述符值事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func writeValueDescriptor(_ handler: @escaping BlueticaCentral.Handler.WriteValueDescriptor) -> Self {
        central.blueticaCentral.peripheralHandler.writeValueDescriptor = handler
        return self
    }

    /// 链式设置写入描述符值回调
    public var writeValueDescriptor: BlueticaCentral.Handler.WriteValueDescriptorResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.writeValueDescriptor = $0
            return Bluetica.default.central
        }
    }

    /// 设置无响应写入回调
    /// - Parameter handler: 无响应写入事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func sendWriteWithoutResponse(_ handler: @escaping BlueticaCentral.Handler.SendWriteWithoutResponse) -> Self {
        central.blueticaCentral.peripheralHandler.sendWriteWithoutResponse = handler
        return self
    }

    /// 链式设置无响应写入回调
    public var sendWriteWithoutResponse: BlueticaCentral.Handler.SendWriteWithoutResponseResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.sendWriteWithoutResponse = $0
            return Bluetica.default.central
        }
    }

    /// 设置打开 L2CAP 信道回调
    /// - Parameter handler: 打开信道事件闭包
    /// - Returns: Self，便于链式调用
    @discardableResult
    public func openChannel(_ handler: @escaping BlueticaCentral.Handler.OpenChannel) -> Self {
        central.blueticaCentral.peripheralHandler.openChannel = handler
        return self
    }

    /// 链式设置打开 L2CAP 信道回调
    public var openChannel: BlueticaCentral.Handler.OpenChannelResult {
        return { [weak central] in
            central?.blueticaCentral.peripheralHandler.openChannel = $0
            return Bluetica.default.central
        }
    }
}
