//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by farkhod on 17.01.2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidviceInput = AlertItem(title: "Invalid Device Input", message: "Ошибка при работе с камерой. Не удалось прочитать данные с устройства", dismissButton: .default(Text("OK")))
    
    static let invalidScannedValue = AlertItem(title: "Invalid Scanned Value", message: "Ошибка чтения данных сканера. Штрих код должен быть EAN18 или EAN13", dismissButton: .default(Text("OK")))
}

struct BarcodeScannerView: View {
    @State var scannedCode = ""
    @State var alertItem: AlertItem?
    
    var body: some View {
        NavigationView{
            VStack {
                ScannerView(
                    scannedCode: $scannedCode,
                    alertItem: $alertItem
                )
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height:  60)
                
                Label("Scanned barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ?.red : .green)
                    .padding()

            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $alertItem, content: { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            })
        }
        
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
