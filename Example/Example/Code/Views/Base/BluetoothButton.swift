//
//  BluetoothScanScanButton.swift
//  Example
//
//  Created by Dream on 2025/8/29.
//

import SwiftUI

struct BluetoothButton: View {

    var action: () -> Void

    private var aModel: BluetoothButtonStyle

    var body: some View {

        Button(action: action) {
            HStack {
                Image(systemName: aModel.imageName.icon)
                Text(aModel.title.text)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .font(aModel.font.font)
            .foregroundStyle(aModel.fontColor.color)
            .background(aModel.backgroundColor.color)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: aModel.cornerRadius))
        }
        .disabled(aModel.disabled)
        .buttonStyle(.plain)

    }

    init(_ model: BluetoothButtonStyle, action: @escaping () -> Void) {
        self.aModel = model
        self.action = action
    }

    var model: (() -> (BluetoothButtonStyle)) -> BluetoothButton {
        return {
            var temp = self
            temp.aModel = $0()
            return temp
        }
    }

}
