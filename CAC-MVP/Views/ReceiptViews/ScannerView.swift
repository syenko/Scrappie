//
//  ScannerView.swift
//  CameraPrototype
//
//  Created by Sabrina on 7/25/22.
//
//  Resources:
//  https://www.appcoda.com/swiftui-text-recognition/
//  https://www.andyibanez.com/posts/scanning-and-text-recognition-with-visionkit/
//

import Foundation
import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    // action handlers (closures)
    var didFinishScanning: ((_ result: Result<[UIImage], Error>) -> Void)
    var didCancelScanning: () -> Void
    
    // nested coordinator class
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var scannedPages = [UIImage]()
            
            for i in 0..<scan.pageCount {
                scannedPages.append(scan.imageOfPage(at: i))
            }
            
            parent.didFinishScanning(.success(scannedPages))
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.didCancelScanning()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            parent.didFinishScanning(.failure(error))
        }
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let vc = VNDocumentCameraViewController();
        vc.delegate = context.coordinator
        
        return vc;
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
