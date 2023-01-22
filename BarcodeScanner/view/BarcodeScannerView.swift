//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by farkhod on 17.01.2023.
//

import SwiftUI

struct BarcodeScannerView: View {
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                ScannerView(
                    scannedCode: $viewModel.scannedCode,
                    alertItem: $viewModel.alertItem
                )
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height:  60)
                
                Label("Scanned barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(viewModel.statusText)
                    .font(.largeTitle)
                    .foregroundColor(viewModel.statusTextColor)
                    .padding()

            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $viewModel.alertItem, content: { alertItem in
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
