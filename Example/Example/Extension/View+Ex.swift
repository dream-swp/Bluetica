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
    
}

extension View {
    @ViewBuilder
    func navigationBarTitleDisplayModeCompat() -> some View {
        #if os(iOS)
            self.navigationBarTitleDisplayMode(.inline)
        #else
            self
        #endif
    }

    var bluetoothBackgroundCardStyle: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.bluetoothCardBackground)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

extension ToolbarItemPlacement {
    static var navigationBarTrailingCompat: ToolbarItemPlacement {
        #if os(iOS)
            return .navigationBarTrailing
        #else
            return .automatic
        #endif
    }
}
