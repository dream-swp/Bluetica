//
//  BlueticaCentral+HandlerCentral.swift
//  Bluetica
//
//  Created by Dream on 2025/9/5.
//

// MARK: - BlueticaCentral.CentralHandler
extension BlueticaCentral {

    /// 蓝牙中心事件处理器，集中存储所有中心相关回调
    struct HandlerCentral {
        /// 恢复中心状态回调
        var restoreState: Handler.RestoreState? = nil
        /// 中心状态更新回调
        var state: Handler.UpdateState? = nil
        /// 发现外设时回调（广播数据）
        var updateDiscover: Handler.UpdateDiscover? = nil
        /// 发现设备对象回调
        var discover: Handler.Discover? = nil
        
        /// 连接成功回调
        var connectSuccess: Handler.SuccessConnect? = nil
        /// 连接失败回调
        var connectFailure: Handler.FailConnect? = nil
        /// 外设断开回调
        var disconnectPeripheral: Handler.DisconnectPeripheral? = nil
        /// 外设断开（带时间戳）回调
        var disconnectPeripheralTimestamp: Handler.DisconnectPeripheralTimestamp? = nil

        /// 扫描开始回调
        var startDiscover: Handler.DiscoverStart? = nil
        /// 扫描停止回调
        var stopDiscover: Handler.DiscoverStop? = nil

        #if os(iOS)
        /// 连接事件回调（仅 iOS）
        var connectionEvent: Handler.ConnectionEvent? = nil
        /// ANCS 授权状态更新回调（仅 iOS）
        var updateANCSAuthorization: Handler.UpdateANCSAuthorization? = nil
        #endif
    }
}
// MARK: -
