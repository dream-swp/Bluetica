//
//  AppState.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//

import Bluetica

struct AppState {
    
    let bluetica = Bluetica.default
    
    var data = DataSignal()
    
    var appSignal = AppSignal()
        
    let appStyle = AppStyle()
}
