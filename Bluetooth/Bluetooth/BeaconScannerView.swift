//
//  BeaconScannerView.swift
//  Bluetooth
//
//  Created by KSU Engineearts on 2024/07/15.
//

import SwiftUI
import CoreBluetooth

struct BeaconScannerView: View {
    @StateObject private var beaconScannerClass = BeaconScannerClass()
    //@ObserverObjectでもいけるかな
    var body: some View {
        Text("スキャンしたやつら")
            .font(.largeTitle)
            .underline(color: .red)
        List(beaconScannerClass.discoveredBeacons, id: \.identifier){beacon in
            Text(beacon.name ?? beacon.identifier.uuidString)
            
        }
    }
}

class BeaconScannerClass: NSObject, ObservableObject, CBCentralManagerDelegate{
    
    var centralManager: CBCentralManager!
    @Published var discoveredBeacons: [CBPeripheral] = []
    
    override init(){
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        if central.state == .poweredOn{
            startScanning()
        }else{
            stopScanning()
        }
    }
    
    func startScanning(){
        guard let centralManager = centralManager else {
            print("Peripheral Manager is nil")
            //nilじゃないことを確認してる
            return
        }
        if centralManager.state == .poweredOn{
            let uuids: [CBUUID] = []
            //CBUUID(string: "gaodisgdsokgvn")
            let options = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
            //重複スキャンを許可してる
            centralManager.scanForPeripherals(withServices: uuids, options: options)
            //ここが実動部分
        }
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        if !discoveredBeacons.contains(peripheral){
            if RSSI.intValue > -120{
                //電波の強度で距離を考えて遠いものは表示しない
                discoveredBeacons.append(peripheral)
                //何でif文in　if文なの？
            }
        }
    }
}
#Preview {
    BeaconScannerView()
}
