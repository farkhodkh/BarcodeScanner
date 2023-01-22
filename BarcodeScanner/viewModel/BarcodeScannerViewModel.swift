//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by farkhod on 22.01.2023.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published  var alertItem: AlertItem?
    
    var statusText: String = {
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ?.red : .green
    }
}
