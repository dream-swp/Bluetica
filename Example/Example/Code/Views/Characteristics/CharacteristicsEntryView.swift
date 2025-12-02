//
//  CharacteristicsSideBarView.swift
//  Example
//
//  Created by Dream on 2025/10/2.
//

import SwiftUI

// MARK: - CharacteristicsEntryView
struct CharacteristicsEntryView: View {

    let characteristics: [Characteristic]

    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        sideBar.toggle(DeviceType.isIphone) { _ in
            NavigationStack { CharacteristicsView(characteristics: characteristics) }
        }
        .onAppear {
            appStore.dispatch(.characteristics(.characteristicsDefaultData))
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

        List(datas, id: \.id) { item in
            CharacteristicsTagBarView(item: item, characteristics: characteristics)
                #if os(iOS)
                    .listStyle(.insetGrouped)
                #endif
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selection == item ? .accent : .clear)
                        .padding(.vertical, 0)
                        .padding(.horizontal, 5)
                )
                .onTapGesture {
                    appStore.dispatch(.characteristics(.characteristicsSelectBarItme(item)))
                }
        }
    }
}

extension CharacteristicsEntryView {
    var datas: [CharacteristicBarItme] { CharacteristicBarItme.allCases }

    private var selection: CharacteristicBarItme {
        appStore.appState.appSignal.characteristicsBarItme
    }
    
}

// MARK: - CharacteristicsTagBarView
private struct CharacteristicsTagBarView: View {
    let item: CharacteristicBarItme
    let characteristics: [Characteristic]
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
    }
}

// MARK: - CharacteristicsGroupView

struct CharacteristicsGroupView: View {

    let characteristics: [Characteristic]

    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(datas, id: \.id) { item in

                    CharacteristicsBarView(item: item, characteristics: characteristics, isSelected: selection == item) {
                        appStore.dispatch(.characteristics(.characteristicsSelectBarItme(item)))
                    }

                }
            }
        }
        .onAppear {
            appStore.dispatch(.characteristics(.characteristicsSelectBarItme(.all)))
        }
    }
}

extension CharacteristicsGroupView {
    private var datas: [CharacteristicBarItme] {
        CharacteristicBarItme.allCases
    }

    private var selection: CharacteristicBarItme {
        appStore.appState.appSignal.characteristicsBarItme
    }
}

// MARK: - CharacteristicsBarView
private struct CharacteristicsBarView: View {

    let item: CharacteristicBarItme
    let characteristics: [Characteristic]
    var isSelected: Bool = false

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(item.rawValue)
                    .font(.callout)
                    .foregroundStyle(.bluetoothBarBackground)
                    .fontWeight(isSelected ? .semibold : .regular)
            }

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
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isSelected ? .blue.opacity(0.2) : .accent)
        .foregroundStyle(.bluetoothBarBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .buttonStyle(.plain)

    }

    init(item: CharacteristicBarItme, characteristics: [Characteristic], isSelected: Bool, action: @escaping () -> Void) {
        self.item = item
        self.characteristics = characteristics
        self.isSelected = isSelected
        self.action = action
    }

}

// MARK: -
