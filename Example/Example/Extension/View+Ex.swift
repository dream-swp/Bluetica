//
//  View+.swift
//  Example
//
//  Created by Dream on 2025/8/25.
//

import SwiftUI

extension View {

    @ViewBuilder
    func toggle<T: View>(_ isToggle: Bool, @ViewBuilder toggle: (Self) -> T) -> some View {
        if isToggle {
            toggle(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func toggle<Value, Content: View>(_ value: Value?, @ViewBuilder toggle: (Self, Value) -> Content) -> some View {
        if let value = value {
            toggle(self, value)
        } else {
            self
        }
    }
    
    var bluetoothBackgroundCardStyle: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.bluetoothCardBackground)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

}

