//
//  ContentView.swift
//  Example
//
//  Created by Dream on 2025/5/18.
//

import Bluetica
import CoreBluetooth
import SwiftUI

struct Model: Identifiable {
    var id: UUID
    var name: String?
    let peripheral: CBPeripheral

}

struct ContentView: View {

    var bluetica = Bluetica.default
    @State var datas: [Model] = []
    @State private var items = [1, 2, 3]
    @State var state: CBManagerState = .unknown

    @State var viewModel = BluetoothViewModel()
    
    var body: some View {

        VStack {
            BluetoothStatusCardView()
            BluetoothScanControlsView()
            
            BluetoothDeviceList()
        }
    }
}

extension ContentView {

    func scan() {

        //        var a = BluetoothScanControls.ScanButtonViewModel()
        //        let _ = a.updateAction {
        //            print("1")
        //        }
        //        let _ = a.updateAction {
        //            //            return print("1")
        //        }
        //        let a = scanModel.startScan.updateAction {
        //            print(123123)
        //        }
        //        print("123123")
        let _ =
            bluetica.central.updateState { manager, central in
                self.state = central.state
                print("central.state = \(central.state)")
            }
            .discover { manager, device in
                if datas.contains(where: { $0.id == device.identifier }) { return }
                let model = Model(id: device.identifier, name: device.name, peripheral: device.peripheral)
                self.datas.append(model)
            }
            .connectSuccess { manager, info in

                print("123123")
            }
            .start

        let _ = bluetica
            .peripheral
            .discoverServices { manager, info in

                print("manager.peripheral.services = \(manager.peripheral.services)")
                print("info.peripheral.services = \(info.peripheral.services ?? [])")
            }
            .discoverCharacteristics { manager, info in
                print("manager.peripheral.characteristics = \(manager.peripheral.characteristics)")
                print("info.service.characteristics = \(info.service.characteristics ?? [])")
            }

    }

    func connect(_ peripheral: CBPeripheral) {
        let _ = bluetica.central.connect {
            peripheral
        }
        //        print("peripheral = \(String(describing: peripheral))")
        //        let _ = bluetica.connect( {peripheral} )
    }

    func test() -> some View {

        VStack {
            Image(systemName: "bluetooth")
            Image(systemName: "bluetooth.slash")
            VStack {
                Button {
                    scan()
                } label: {
                    Text("Bluetica")
                }
                .buttonStyle(.plain)

                List {
                    ForEach(datas) { data in
                        Button {
                            connect(data.peripheral)
                        } label: {
                            Text(data.name ?? "")
                        }

                    }

                }

            }
            #if os(macOS)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            #endif
            .padding()
        }

    }

}

#Preview {
    ContentView().environmentObject(AppStore())
}
