//
//  ImagePicker.swift
//  FoodScannerApp
//
//  Created by Sabrina on 10/16/22.
//

import UIKit
import SwiftUI

enum ImagePickerError: Error {
    case invalidSelection
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .camera
    
    // action handlers (closures)
    var didFinishGettingImage: ((_ result: Result<UIImage, Error>) -> Void)
    var didCancelGettingImage: () -> Void
    
    // create coordinator object that handles functionality when UIImagePicker is used
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // make picker go away
            
            // try to assign image
            // need type cast (as? UIImage) because could return some other type of media
            guard let image = info[.originalImage] as? UIImage else {
                // otherwise, exit
                self.parent.didFinishGettingImage(.failure(ImagePickerError.invalidSelection))
                return
            }
            
            parent.didFinishGettingImage(.success(image))
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.didCancelGettingImage()
        }
        
        func imagePickerController(_ controller: UIImagePickerController, didFailWithError error: Error) {
            parent.didFinishGettingImage(.failure(error))
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // initialize UIImagePickerController
        let vc = UIImagePickerController()
        vc.sourceType = sourceType
        vc.allowsEditing = true
        
        // assign delegate
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // create and pass back instance of Coordinator
    // automatically called when instance of ImagePicker is created
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
