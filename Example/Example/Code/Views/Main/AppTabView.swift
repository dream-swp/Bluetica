//
//  AppTabView.swift
//  Example
//
//  Created by Dream on 2025/9/12.
//

import SwiftUI

struct AppTabView: View {

    static let mainBarView = AppTabView()
    
    @EnvironmentObject private var appStore: AppStore
    
    @State private var selection: AppTabItem = .scan
    
    var body: some View {
        sideBar
            .toggle(DeviceType.isIphone) { _ in
                tabView
            }
            .onChange(of: selection) { oldValue, newValue in
                if oldValue != newValue {
                    print("newValue: \(newValue)  pls clear device ...")
                }
            }
    }

}

extension AppTabView {

    var sideBar: some View {
        NavigationSplitView {
            listView
        } content: {
            selection.target
        } detail: {
            EmptyView()
                .toggle(device) { _, device in
                DeviceInfoEntryView()
            }

        }
        .tint(.bluetoothBarBackground)
        .toggle(DeviceType.isIpad) { _ in
            NavigationSplitView {
                listView
            } detail: {
                selection.target
                   
            }
            .tint(.bluetoothBarBackground)
        }

    }

    var tabView: some View {
        TabView(selection: $selection) {
            ForEach(AppTabItem.itmes) { itme in
                Tab(value: itme) {
                    NavigationView { itme.target }
                } label: {
                    SideBar(item: itme)
                }
            }
        }
        .tint(.bluetoothBarBackground)
        .tabViewStyle(.sidebarAdaptable)

    }

    var listView: some View {
        #if os(macOS)
            List(itmes, selection: $selection) {
                SideBar(item: $0)
            }
        #else
            List(itmes, id: \.id) { item in
                SideBar(item: item)
                    .listStyle(InsetGroupedListStyle())
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selection == item ? .accent : .clear)
                            .padding(.vertical, 0)
                            .padding(.horizontal, 0)
                    )

                    .onTapGesture {
                        selection = item
                    }
                    
            }
            .background(.bluetoothBarBackground)
            .tabViewStyle(.sidebarAdaptable)
        #endif

    }
}

extension AppTabView {

    private struct SideBar: View {
        let item: AppTabItem
        var body: some View {
            HStack(spacing: 10) {
                Image(systemName: item.image)
                    .foregroundStyle(.bluetoothBarBackground)
                    .font(.title2)
                    .frame(width: 25, height: 25)
                Text(item.title).multilineTextAlignment(.leading)
                    .foregroundStyle(.bluetoothBarBackground)
            }.toggle(DeviceType.isIphone) { _ in
                Label(
                    title: { Text(item.title).minimumScaleFactor(0.5) },
                    icon: { Image(systemName: item.image) }
                )
            }
        }
    }

}

extension AppTabView {
    
    private var device: Device? {
        appStore.appState.data.device
    }
    
    private var itmes: [AppTabItem]  {
        AppTabItem.itmes
    }
}

#Preview {
    AppTabView().environmentObject(AppStore())
}
