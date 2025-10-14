//
//  BlueticaCentral+Handler.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

import CoreBluetooth
import Foundation

// MARK: - BlueticaCentral.Handler
extension BlueticaCentral {
    /// 蓝牙中心和外设事件处理协议，所有回调类型定义于此
    public protocol Handler {}
}

// MARK: - BlueticaCentral.Central Handler Type alias
extension BlueticaCentral.Handler {

    /// 中心管理器类型
    public typealias CentralManager = Bluetica
    /// 中心回调链式返回类型
    public typealias CentralResult = BlueticaCentral.Central<Bluetica>

    /// 恢复中心状态回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含 CBCentralManager 和恢复字典
    public typealias RestoreState = (_ manager: CentralManager, _ info: (central: CBCentralManager, dict: [String: Any])) -> Void
    /// 链式设置恢复中心状态回调
    public typealias RestoreStateResult = (@escaping RestoreState) -> CentralResult

    /// 中心状态更新回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - central: CBCentralManager
    public typealias UpdateState = (_ manager: CentralManager, _ central: CBCentralManager) -> Void
    /// 链式设置中心状态更新回调
    public typealias UpdateStateResult = (@escaping UpdateState) -> CentralResult

    /// 发现外设时回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含 central、peripheral、广播数据、rssi
    public typealias UpdateDiscover = (_ manager: CentralManager, _ info: (central: CBCentralManager, peripheral: CBPeripheral, advertisementData: [String: Any], rssi: NSNumber)) -> Void
    /// 链式设置发现外设回调
    public typealias UpdateDiscoverResult = (@escaping UpdateDiscover) -> CentralResult

    /// 发现设备对象回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - device: 设备对象
    public typealias Discover = (_ manager: CentralManager, _ info:(device: BlueticaCentral.Device,  central: CBCentralManager)) -> Void
    /// 链式设置发现设备对象回调
    public typealias DiscoverResult = (@escaping Discover) -> CentralResult

    /// 连接成功回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含 central、peripheral
    public typealias SuccessConnect = (_ manager: CentralManager, _ info: (device: BlueticaCentral.Device?, central: CBCentralManager, peripheral: CBPeripheral)) -> Void
    /// 链式设置连接成功回调
    public typealias SuccessConnectResult = (@escaping SuccessConnect) -> CentralResult

    /// 连接失败回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含 central、peripheral、error
    public typealias FailConnect = (_ manager: CentralManager, _ info: (device: BlueticaCentral.Device?, central: CBCentralManager, peripheral: CBPeripheral, error: Error?)) -> Void
    /// 链式设置连接失败回调
    public typealias FailConnectResult = (@escaping FailConnect) -> CentralResult

    /// 外设断开回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含 central、peripheral、error
    public typealias DisconnectPeripheral = (_ manager: CentralManager, _ info: (device: BlueticaCentral.Device?, central: CBCentralManager, peripheral: CBPeripheral, error: Error?)) -> Void
    /// 链式设置外设断开回调
    public typealias DisconnectPeripheralResult = (@escaping DisconnectPeripheral) -> CentralResult

    /// 外设断开（带时间戳）回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含 central、peripheral、timestamp、isReconnecting、error
    public typealias DisconnectPeripheralTimestamp = (_ manager: CentralManager, _ info: (device: BlueticaCentral.Device?, central: CBCentralManager, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: Error?)) -> Void
    /// 链式设置外设断开（带时间戳）回调
    public typealias DisconnectPeripheralTimestampResult = (@escaping DisconnectPeripheralTimestamp) -> CentralResult

    /// 扫描开始回调
    public typealias DiscoverStart = () -> Void
    /// 链式设置扫描开始回调
    public typealias DiscoverStartResult = (@escaping DiscoverStart) -> CentralResult

    /// 扫描停止回调
    public typealias DiscoverStop = () -> Void
    /// 链式设置扫描停止回调
    public typealias DiscoverStopResult = (@escaping DiscoverStop) -> CentralResult

    #if os(iOS)
    /// 连接事件回调（仅 iOS）
    /// - Parameters:
    ///   - manager: 外设管理器
    ///   - info: 包含 central、event、peripheral
    public typealias ConnectionEvent = (_ manager: PeripheralManager, _ info: (central: CBCentralManager, event: CBConnectionEvent, peripheral: CBPeripheral)) -> Void
    /// 链式设置连接事件回调
    public typealias ConnectionEventResult = (@escaping ConnectionEvent) -> CentralResult
    /// ANCS 授权状态更新回调（仅 iOS）
    /// - Parameters:
    ///   - manager: 外设管理器
    ///   - info: 包含 central、peripheral
    public typealias UpdateANCSAuthorization = (_ manager: PeripheralManager, _ info: (central: CBCentralManager, peripheral: CBPeripheral)) -> Void
    /// 链式设置 ANCS 授权状态更新回调
    public typealias UpdateANCSAuthorizationResult = (@escaping UpdateANCSAuthorization) -> CentralResult
    #endif
}

// MARK: - BlueticaCentral.Peripheral Handler Type alias
extension BlueticaCentral.Handler {

    /// 外设管理器类型
    public typealias PeripheralManager = Bluetica
    /// 外设回调链式返回类型
    public typealias PeripheralResult = BlueticaCentral.Central<Bluetica>

    /// 外设名称更新回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - peripheral: 外设对象
    public typealias UpdateName = (_ manager: PeripheralManager, _ peripheral: CBPeripheral) -> Void
    /// 链式设置外设名称更新回调
    public typealias UpdateNameResult = (@escaping UpdateName) -> PeripheralResult

    /// 服务变更回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含外设和失效服务数组
    public typealias ModifyServices = (_ manager: PeripheralManager, _ info: (peripheral: CBPeripheral, invalidatedServices: [CBService])) -> Void
    /// 链式设置服务变更回调
    public typealias ModifyServicesResult = (@escaping ModifyServices) -> PeripheralResult

    /// RSSI 更新回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含外设和错误信息
    public typealias UpdateRSSI = (_ manager: PeripheralManager, _ info: (peripheral: CBPeripheral, error: Error?)) -> Void
    /// 链式设置 RSSI 更新回调
    public typealias UpdateRSSIResult = (@escaping UpdateRSSI) -> PeripheralResult

    /// 读取 RSSI 回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含外设、RSSI、错误信息
    public typealias ReadRSSI = (_ manager: PeripheralManager, _ info: (peripheral: CBPeripheral, RSSI: NSNumber, error: Error?)) -> Void
    /// 链式设置读取 RSSI 回调
    public typealias ReadRSSIResult = (@escaping ReadRSSI) -> PeripheralResult

    /// 服务发现回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含外设和错误信息
    public typealias DiscoverServices = (_ manager: PeripheralManager, _ info: (device: BlueticaCentral.Device?, peripheral: CBPeripheral, error: Error?)) -> Void
    /// 链式设置服务发现回调
    public typealias DiscoverServicesResult = (@escaping DiscoverServices) -> PeripheralResult

    /// 服务信息元组
    public typealias Service = (device: BlueticaCentral.Device?, peripheral: CBPeripheral, service: CBService, error: Error?)

    /// 包含服务发现回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Service 元组
    public typealias DiscoverIncludedServices = (_ manager: PeripheralManager, _ info: Service) -> Void
    /// 链式设置包含服务发现回调
    public typealias DiscoverIncludedServicesResult = (@escaping DiscoverIncludedServices) -> PeripheralResult

    /// 特征值发现回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Service 元组
    public typealias DiscoverCharacteristics = (_ manager: PeripheralManager, _ info: Service) -> Void
    /// 链式设置特征值发现回调
    public typealias DiscoverCharacteristicsResult = (@escaping DiscoverCharacteristics) -> PeripheralResult

    /// 特征值信息元组
    public typealias Characteristic = (peripheral: CBPeripheral, characteristic: CBCharacteristic, error: Error?)

    /// 特征值更新回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Characteristic 元组
    public typealias UpdateValue = (_ manager: PeripheralManager, _ data: Data? , _ info: Characteristic) -> Void
    /// 链式设置特征值更新回调
    public typealias UpdateValueResult = (@escaping UpdateValue) -> PeripheralResult

    /// 写入特征值回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Characteristic 元组
    public typealias WriteValue = (_ manager: PeripheralManager, _ info: Characteristic) -> Void
    /// 链式设置写入特征值回调
    public typealias WriteValueResult = (@escaping WriteValue) -> PeripheralResult

    /// 通知状态更新回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Characteristic 元组
    public typealias UpdateNotificationState = (_ manager: PeripheralManager, _ info: Characteristic) -> Void
    /// 链式设置通知状态更新回调
    public typealias UpdateNotificationStateResult = (@escaping UpdateNotificationState) -> PeripheralResult

    /// 描述符发现回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Characteristic 元组
    public typealias DiscoverDescriptors = (_ manager: PeripheralManager, _ info: Characteristic) -> Void
    /// 链式设置描述符发现回调
    public typealias DiscoverDescriptorsResult = (@escaping DiscoverDescriptors) -> PeripheralResult

    /// 描述符信息元组
    public typealias Descriptor = (peripheral: CBPeripheral, descriptor: CBDescriptor, error: Error?)

    /// 描述符值更新回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Descriptor 元组
    public typealias UpdateValueDescriptor = (_ manager: PeripheralManager, _ info: Descriptor) -> Void
    /// 链式设置描述符值更新回调
    public typealias UpdateValueDescriptorResult = (@escaping UpdateValueDescriptor) -> PeripheralResult

    /// 写入描述符值回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: Descriptor 元组
    public typealias WriteValueDescriptor = (_ manager: PeripheralManager, _ info: Descriptor) -> Void
    /// 链式设置写入描述符值回调
    public typealias WriteValueDescriptorResult = (@escaping WriteValueDescriptor) -> PeripheralResult

    /// 无响应写入回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - peripheral: 外设对象
    public typealias SendWriteWithoutResponse = (_ manager: PeripheralManager, _ peripheral: CBPeripheral) -> Void
    /// 链式设置无响应写入回调
    public typealias SendWriteWithoutResponseResult = (@escaping SendWriteWithoutResponse) -> PeripheralResult

    /// 打开 L2CAP 信道回调
    /// - Parameters:
    ///   - manager: 管理器实例
    ///   - info: 包含外设、信道、错误信息
    public typealias OpenChannel = (_ manager: PeripheralManager, _ info: (peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: Error?)) -> Void
    /// 链式设置打开 L2CAP 信道回调
    public typealias OpenChannelResult = (@escaping OpenChannel) -> PeripheralResult

}
// MARK: -
