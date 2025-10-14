//
//  DeviceInfoDataCommunicationView.swift
//  Example
//
//  Created by Dream on 2025/9/26.
//

import SwiftUI

struct DeviceInfoDataCommunicationView: View {

    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleView

            characteristicsView

            receivedDataListView

            operationButtons

            sendDataView

        }
        .padding()
    }
}

extension DeviceInfoDataCommunicationView {

    private var device: Device? {
        appStore.appState.data.device
    }

    private var characteristics: [Characteristics] {
        device?.characteristics ?? []
    }

    private var characteristic: Characteristics? {
        appStore.appState.data.characteristic
    }

    private var characteristicName: String {
        characteristic?.name ?? "请选择特征"
    }

    private var characteristicNameColor: Color {
        characteristic != nil ? .primary : .secondary
    }

    private var appSignalBinding: Binding<AppSignal> {
        $appStore.appState.appSignal
    }

    private var sendTextBinding: Binding<String> {
        $appStore.appState.appSignal.characteristicSendText
    }

    private var sendText: String {
        appStore.appState.appSignal.characteristicSendText
    }

    private var writeModeItemBinding: Binding<WriteModeItem> {
        appSignalBinding.characteristicSelectedWriteModeItem
    }

    private var writeModeItem: WriteModeItem {
        appStore.appState.appSignal.characteristicSelectedWriteModeItem
    }

    private var writeDataItemBinding: Binding<WriteDataItem> {
        appSignalBinding.characteristicSelectedWriteDataItem
    }

    private var writeDataItem: WriteDataItem {
        appStore.appState.appSignal.characteristicSelectedWriteDataItem
    }

}

extension DeviceInfoDataCommunicationView {

    private var titleView: some View {
        Text("数据通信")
            .font(.headline)
            .foregroundStyle(.primary)
    }

    private var characteristicsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("选择特征:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()

                Text("共 \(characteristics.count) 个")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(characteristics.isEmpty ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
                    .foregroundStyle(characteristics.isEmpty ? .red : .green)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

            }

            Button {
                appStore.dispatch(.deviceInfo(.displayCharacteristicsList(characteristics.count > 0)))
            } label: {
                HStack {
                    Text(characteristicName)
                        .foregroundStyle(characteristicNameColor)

                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.red)
                        .toggle(characteristics.count > 0) { _ in
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.blue)
                        }
                }
                .padding()
                .background(.bluetoothCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(characteristics.count < 0)
            .buttonStyle(.plain)

            Text("暂无可用特征 - 请确保设备已连接并完成服务发现")
                .font(.caption)
                .foregroundStyle(.red)
                .toggle(characteristic) { _, value in
                    CharacteristicsTags(characteristic: value)
                }

        }
    }

    private var receivedDataListView: some View {

        Section {
            EmptyView().toggle((characteristic?.data.count ?? 0) > 0, characteristic) { _, characteristic in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(ReceivedItem.allCases) { DeviceInfoReceivedCell(item: $0, characteristic: characteristic) { print("12321312") } }
                    }
                }

            }
        } header: {
            Text("接收数据:")
                .font(.subheadline)
                .fontWeight(.medium)
        }

    }

    public var operationButtons: some View {
        HStack(spacing: 8) {
            ButtonView(appStore.appState.appStyle.button.characteristicReceiving) {
                appStore.dispatch(.deviceInfo(.receivingData))
            }

            .frame(width: 100, height: 30)

            ButtonView(appStore.appState.appStyle.button.characteristicNotify) {
                print("123123")
            }
            .frame(width: 120, height: 30)
        }
        .bold()

    }

    public var sendDataView: some View {

        Section {
            HStack {
                TextField("输入要发送的数据", text: sendTextBinding)
                    .textFieldStyle(.roundedBorder)
                    .disabled(characteristic == nil)

                Button {
                    appStore.dispatch(.deviceInfo(.sendData))
                } label: {
                    Text("发送")
                        .foregroundStyle((sendText.isEmpty || characteristic == nil) ? .gray : .green)
                }
                .frame(height: 10)
                .disabled(sendText.isEmpty)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .buttonStyle(.plain)
            }
            .padding(.vertical, 5)
        } header: {
            VStack {
                
                HStack {
                    Text("发送数据:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Picker(selection: writeModeItemBinding) {
                        ForEach(WriteModeItem.allCases) {
                            Label($0.rawValue, systemImage: $0.icon)
                        }
                    } label: {

                        Label(writeModeItem.rawValue, systemImage: writeModeItem.icon)
                            .labelStyle(.automatic)
                            .font(.system(.caption2))
                    }
                    .font(.system(.caption2))
                    .pickerStyle(.automatic)

                    Picker(selection: writeDataItemBinding) {
                        ForEach(WriteDataItem.allCases) {
                            Label($0.rawValue, systemImage: $0.icon)
                        }
                    } label: {
                        Label(writeDataItem.rawValue, systemImage: writeDataItem.icon)
                            .labelStyle(.automatic)
                            .font(.system(.caption2))
                    }
                    .font(.system(.caption2))
                    .pickerStyle(.automatic)
                }
            }

        }
    }

}
