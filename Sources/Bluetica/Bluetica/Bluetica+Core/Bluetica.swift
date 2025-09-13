//
//  Bluetica.swift
//  Bluetica
//
//  Created by Dream on 2025/8/16.
//

import CoreBluetooth
import Foundation

final public class Bluetica: NSObject, ObservableObject, @unchecked Sendable {

    public static let `default` = Bluetica()

    var blueticaCentral = BlueticaCentral.default
    
    var timer: Timer?

    var centralManager: CBCentralManager!
    

    // MARK: - private
    private override init() {
        super.init()
        self.centralManager = blueticaCentral.centralManager { (delegate: self, isBackgroundMode: self.verify.isBackgroundMode) }
    }
    
    
    deinit {
        timer?.invalidate()
    }

}


extension Bluetica {
    
    func startScan() {
        if central.isEnabled == false { return }
        blueticaCentral.centralHandler.startDiscover?()
        centralManager.scanForPeripherals(withServices: blueticaCentral.centralConfig.services, options: blueticaCentral.centralConfig.scanOptions)
        switch blueticaCentral.centralConfig.scan {
        case .none: break
        case .time(let timeInterval):
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
                
                self?.central.stop()
            }
        }
        blueticaCentral.isScanning = true
    }
    
    
    public func stopScan(_ isRemove: Bool = false) -> Self {
        timer?.invalidate()
        timer = nil
        if blueticaCentral.isScanning == false  { return self }
        centralManager.stopScan()
        blueticaCentral.isScanning = false
        if isRemove {
            blueticaCentral.peripherals.discover.removeAll()
        }
        blueticaCentral.centralHandler.stopDiscover?()
        return self
    }
    
}
