//
//  ScannerViewControllerDelegate.swift
//  BarcodeScanner
//
//  Created by farkhod on 22.01.2023.
//

import AVFoundation
import UIKit

protocol ScannerViewControllerDelegate: AnyObject {
    func didSurfaceError(error: ScannerError)
    func didFind(barcode: String)
}
