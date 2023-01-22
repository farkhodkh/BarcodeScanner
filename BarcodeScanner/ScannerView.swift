//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by farkhod on 22.01.2023.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(scannerDelegate:context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didSurfaceError(error: ScannerError) {
            switch (error) {
            case .invalidDeviceError:
                scannerView.alertItem = AlertContext.invalidviceInput
            case .invalidScannedValue:
                scannerView.alertItem = AlertContext.invalidScannedValue
            }
        }
        
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
            print(barcode)
        }
    }
}
//
//struct ScannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScannerView(
//            scannedCode: .constant("123456789"),
//            alertItem: nil
//        )
//    }
//}
