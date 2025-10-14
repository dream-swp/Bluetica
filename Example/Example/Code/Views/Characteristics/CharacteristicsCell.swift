//
//  CharacteristicsCell.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import SwiftUI
import CoreBluetooth

struct CharacteristicsCell: View {

    let characteristic: Characteristics
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(characteristic.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.bluetoothText)
                            .lineLimit(3)

                    
                        Text(characteristic.uuid)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()

                    EmptyView().toggle(isSelected) { _ in
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.orange)
                            .font(.title3)
                    }
                }
                
                CharacteristicsTags(characteristic: characteristic)
            }
            .padding(12)
            .background(

                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? .blue.opacity(0.1) : .bluetoothCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? .blue : .clear, lineWidth: 2)
                    )
            )

        }
        .buttonStyle(.plain)
    }
}

