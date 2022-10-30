//
//  ImagePicker.swift
//  CameraPrototype
//
//  Created by Sabrina on 7/17/22.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    // create coordinator object that handles functionality when UIImagePicker is used
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // make picker go away
            self.parent.isPresented = false
            
            // try to assign image
            // need type cast (as? UIImage) because could return some other type of media
            guard let image = info[.originalImage] as? UIImage else {
                // otherwise, exit
                print("No image found")
                return
            }
            
            self.parent.image = image
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.isPresented = false
        }
    }
    
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // initialize UIImagePickerController
        let vc = UIImagePickerController()
        vc.sourceType = sourceType
//        vc.allowsEditing = true
        
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
