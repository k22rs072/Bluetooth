//
//  ContentView.swift
//  Bluetooth
//
//  Created by KSU Engineearts on 2024/07/15.
//
import CoreBluetooth
import SwiftUI


struct ContentView: View {
    
    var body: some View {
        Text("UNKNOWN")
            .font(Font.system(size: 72, design: .rounded))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.gray)
            .ignoresSafeArea(.all)
    }
}
#Preview {
    ContentView()
}
