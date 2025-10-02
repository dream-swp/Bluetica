//
//  CharacteristicsSideBarView.swift
//  Example
//
//  Created by Dream on 2025/10/2.
//

import SwiftUI

struct CharacteristicsEntryView: View {

    let characteristics: [Characteristics]

    @State private var selection = CharacteristicsSideBarItme.all

    var body: some View {
        sideBar.toggle(DeviceType.isIphone) { _ in
            NavigationStack { CharacteristicsView(characteristics: characteristics) }
        }
    }
}

extension CharacteristicsEntryView {

    
    var sideBar: some View {
        
        NavigationSplitView {
            listView
        } detail: {
            NavigationStack { CharacteristicsView(characteristics: characteristics) }
        }
        .tint(.bluetoothBarBackground)
#if os(macOS)
        .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
#endif
    
    }
    

    private var listView: some View {
#if os(macOS)

        List(datas, selection: $selection) { item in
            CharacteristicsTagBarView(item: item, characteristics: characteristics)
        }

#else
        List(datas, id: \.id) { item in
            //                SideBar(item: $0)
            CharacteristicsTagBarView(item: item, characteristics: characteristics)
                .listStyle(.insetGrouped)

            .listRowBackground(
                RoundedRectangle(cornerRadius: 10)
                    .fill(selection == item ? .accent : .clear)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 5)
            )
            .onTapGesture {
                selection = item
            }
        }
        #endif

    }
}

extension CharacteristicsEntryView {

    var datas: [CharacteristicsSideBarItme] { CharacteristicsSideBarItme.allCases }
}

// MARK: - CharacteristicsBarView
private struct CharacteristicsBarView: View {

    let item: CharacteristicsSideBarItme
    let characteristics: [Characteristics]
    let isSelected: Bool = false

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(item.rawValue)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }

            Text("\(item.count { characteristics } )")
                .font(.caption2)
                .padding(.horizontal, 4)
                .padding(.vertical, 1)
                .background(isSelected ? Color.white.opacity(0.3) : Color.primary.opacity(0.2))
                .clipShape(Circle())

        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isSelected ? Color.blue : Color.bluetoothCharacteristicsSearch)
        .foregroundStyle(isSelected ? .white : .primary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .buttonStyle(.plain)

    }

}

struct CharacteristicsTagBarView: View {
    let item: CharacteristicsSideBarItme
    let characteristics: [Characteristics]
    let isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 5) {
            Text(item.rawValue)
                .padding(.horizontal, 5)
                .foregroundStyle(.bluetoothBarBackground)
            
            Spacer()
            Text("\(item.count { characteristics } )")
                .foregroundStyle(.bluetoothBarBackground)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(width: 15, height: 15)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(isSelected ? Color.white.opacity(0.3) : Color.primary.opacity(0.2))
                .clipShape(Circle())
                
        }
        .contentShape(Rectangle())
       
        .buttonStyle(.plain)
    }
}
