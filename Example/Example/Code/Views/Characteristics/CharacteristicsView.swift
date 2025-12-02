//
//  CharacteristicsEntryView 2.swift
//  Example
//
//  Created by Dream on 2025/10/2.
//


import SwiftUI

struct CharacteristicsView: View {

    @EnvironmentObject private var appStore: AppStore

    @Environment(\.dismiss) private var dismiss

    @State var searchText = ""
    var characteristics: [Characteristic]

    var body: some View {

        VStack(spacing: 0) {

            VStack(spacing: 12) {

//                searchView
                
                EmptyView()
                    .toggle(DeviceType.isIphone) { _  in
                    CharacteristicsGroupView(characteristics: characteristics)
                }
              
                //
                placeholderView
                    .toggle(characteristics.count > 0 && isSearchTextEmpty) { _ in
                        CharacteristicsListView(datas: datas)
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

        }
        
        .navigationTitle("选择特征")
        .navigationBarTitleDisplayModeCompat()
                
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    appStore.dispatch(.deviceInfo(.displayCharacteristicsList(false)))
                
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
                .buttonStyle(.plain)

            }
        }
        

    }
}

extension CharacteristicsView {

    private var searchView: some View {

        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("搜索特征...", text: characteristicsSearchText)
                .textFieldStyle(.plain)
                .autocorrectionDisabled(false)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.bluetoothCharacteristicsSearch)
        .background(.bluetoothCharacteristicsSearch)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var placeholderView: some View {

        VStack(spacing: 16) {
            PlaceholderView {
                ("antenna.radiowaves.left.and.right.slash", "暂无可用特征", "请确保设备已连接并完成服务发现")
            }
            .toggle(!isSearchTextEmpty) { _ in
                PlaceholderView {
                    ("magnifyingglass", "未找到匹配的特征", nil)
                }

                Button("清除搜索") {
                    characteristicsSearchText.wrappedValue = ""
                }
                .font(.caption)
                .foregroundStyle(.blue)
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 40)
    }

}

extension CharacteristicsView {


    private var barItme: CharacteristicBarItme? {
        appStore.appState.appSignal.characteristicsBarItme
    }
    
    private var datas: [(service: String, characteristics: [Characteristic])] {
        barItme?.datas { characteristics } ?? []
    }

    private var isSearchTextEmpty: Bool {
        characteristicsSearchText.wrappedValue.isEmpty
    }

    private var characteristicsSearchText: Binding<String> {
        $appStore.appState.appSignal.characteristicsSearchText
    }

}
