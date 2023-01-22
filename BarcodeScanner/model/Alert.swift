//
//  Alert.swift
//  BarcodeScanner
//
//  Created by farkhod on 22.01.2023.
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
