//
//  CharacteristicsListView.swift
//  Example
//
//  Created by Dream on 2025/10/1.
//

import SwiftUI

// MARK: - CharacteristicsListView
struct CharacteristicsListView: View {

    @EnvironmentObject private var appStore: AppStore
    
    var datas: [(service: String, characteristics: [Characteristics])]
    
    var body: some View {

        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {

                ForEach(datas, id: \.service) { group in
                    VStack(alignment: .leading, spacing: 12) {
                        
                        headView { group }
                        
                        listView { (group.characteristics, characteristic)  }
                    }
                }
            }
        }
        .padding(.vertical, 16)
    }
}

extension CharacteristicsListView {

    private func headView(_ handler: () -> (service: String, characteristics: [Characteristics])) -> some View {

        VStack(alignment: .leading, spacing: 12) {
            let info = handler()
            HStack {
                Image(systemName: info.service.serviceInfo.image)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.bluetoothIcon)
                Text(info.service.serviceInfo.title)
                    .font(.headline)
                    .foregroundStyle(.bluetoothText)
                Spacer()
                Text("\(info.characteristics.count)")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.2))
                    .foregroundStyle(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .padding(.horizontal, 16)
        }
    }

    private func listView(_ handler: () -> (characteristics: [Characteristics], itme: Characteristics?)) -> some View {
        
        LazyVGrid(columns: columns, spacing: 8) {
            let result = handler()
            ForEach(result.characteristics) { characteristic in
                CharacteristicsCell(characteristic: characteristic, isSelected: result.itme == characteristic ) {
                    appStore.dispatch(.characteristics(.characteristicsSelect(characteristic)))
                }
            }
        }
        .padding(.horizontal, 16)
    }

}

extension CharacteristicsListView {
    private var columns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible(), spacing: 8),
        ]
    }
    
    private var characteristic: Characteristics? {
        appStore.appState.data.characteristic
    }
    
}


