//
//  ScannerViewController.swift
//  BarcodeScanner
//
//  Created by farkhod on 22.01.2023.
//

import AVFoundation
import UIKit

final class ScannerViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerViewControllerDelegate?
    
    init(scannerDelegate: ScannerViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurfaceError(error: .invalidDeviceError)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurfaceError(error: .invalidDeviceError)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
            scannerDelegate?.didSurfaceError(error: .invalidDeviceError)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didSurfaceError(error: .invalidDeviceError)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            scannerDelegate?.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let objects = metadataObjects.first else {
            scannerDelegate?.didSurfaceError(error: .invalidScannedValue)
            return
            
        }
        
        guard let machineReadableObjects = objects as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurfaceError(error: .invalidScannedValue)
            return
            
        }
        
        guard let barcode = machineReadableObjects.stringValue else {
            scannerDelegate?.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        scannerDelegate?.didFind(barcode: barcode)
    }
}
