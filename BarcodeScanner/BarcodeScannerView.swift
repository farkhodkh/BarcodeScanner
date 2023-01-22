//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by farkhod on 17.01.2023.
//

import SwiftUI

struct BarcodeScannerView: View {
    @State var scannedCode = ""
    
    var body: some View {
        NavigationView{
            VStack {
                ScannerView(scannedCode: $scannedCode )
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
        }
        
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
