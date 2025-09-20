//
//  BluetoothViewModel.swift
//  Example
//
//  Created by Dream on 2025/8/28.
//

struct BluetoothViewModel {

    var statusCarStyle: BluetoothStatusCardStyle = .statusCarStyle
    
    let startButtonStyle: BluetoothButtonStyle = .startStyle
    let stopButtonStyle: BluetoothButtonStyle = .stopStyle
    let clearButtonStyle: BluetoothButtonStyle = .clearStyle
    let connectButtnStyle: BluetoothButtonStyle = .connectStyle
    let infoButtnStyle: BluetoothButtonStyle = .infoStyle

    var deviceInfoButtons: [BluetoothButtonStyle] = [.disconnectStyle, .subscribeStyle, .refreshFeatureStyle, .characteristicCountStyle]
}
