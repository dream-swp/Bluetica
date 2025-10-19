//
//  AppSignalStatus.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import Foundation
import SwiftUI


class AppSignal {
    
    
    var isDisplayCharacteristicsList = false
    
    var characteristicsBarItme: CharacteristicBarItme = .all
    
    var characteristicsSearchText: String = ""
    
    var characteristicSendText: String = ""
    
    var characteristicSelectedWriteModeItem: WriteModeItem = .writeResponse
    
    var characteristicSelectedWriteDataItem: WriteDataItem = .string
    
}
