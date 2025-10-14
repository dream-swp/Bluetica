//
//  BluetoothScanScanButton.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

import SwiftUI

struct ButtonView: View {

    var action: () -> Void

    var style: AppButtonStyleType

    var body: some View {

        Button(action: action) {
            HStack {
                EmptyView().toggle(style.imageName.icon.isEmpty == false) { _ in
                    Image(systemName: style.imageName.icon)
                }
                Text(style.title.text)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .font(style.font.font)
            .foregroundStyle(style.fontColor.color)
            .background(style.backgroundColor.color)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius))
        }
        .disabled(style.disabled)
        .buttonStyle(.plain)

    }

    init(_ model: AppButtonStyleType, action: @escaping () -> Void) {
        self.style = model
        self.action = action
    }

    func style(_ handler: () -> AppButtonStyleType) -> ButtonView {
        var temp = self
        temp.style = handler();
        return temp
    }

}
