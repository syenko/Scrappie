//
//  FoodImageSegmentation.swift
//  FoodScannerApp
//
//  Created by Sabrina on 10/16/22.
//
//  Resources:
//  https://developer.apple.com/documentation/vision/classifying_images_with_vision_and_core_ml

import Foundation
import SwiftUI
import Vision

class ImageSegmentation {
    static func createSegmentationModel() -> VNCoreMLModel {
        // Create an instance of the segmentation model's wrapper class.
        let imageSegmentationWrapper = try? FoodSegUNet()
        
        guard let imageSegmentation = imageSegmentationWrapper else {
            fatalError("App failed to create an image segmenter model instance")
        }
        
        // Get the underlying model instance
        let segmentationModel = imageSegmentation.model
        
        guard let imageSegmentationVisionModel = try? VNCoreMLModel(for: segmentationModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        return imageSegmentationVisionModel
    }
    
    private static let imageSegmentationModel = createSegmentationModel()
    
    struct Segmentation {
        let segmentationImage: UIImage
        
        let confidencePercentage: Float
    }
    
    typealias ImageSegmentationHandler = (_ segmentations:[Segmentation]?) -> Void
    
    // dictionary of segmentation handler functions, key is Vision request
    private var segmentationHandlers = [VNRequest: ImageSegmentationHandler]()
    
    private func createImageSegmentationRequest() -> VNImageBasedRequest {
        let imageSegmentationRequest = VNCoreMLRequest(model: ImageSegmentation.imageSegmentationModel, completionHandler: visionRequestHandler)
        
        imageSegmentationRequest.imageCropAndScaleOption = .centerCrop
        return imageSegmentationRequest
    }
    
    func makePredictions(for photo: UIImage, completionHandler: @escaping ImageSegmentationHandler) {
        let queue = DispatchQueue(label: "imageSegmentationQueue", qos: .userInitiated)
        queue.async {
            let orientation = CGImagePropertyOrientation(photo.imageOrientation)
            
            // check to see if image has cgImage, otherwise return
            guard let photoImage = photo.cgImage else { return }
            
            let imageSegmentationRequest = self.createImageSegmentationRequest()
            
            // add completion handler in main queue
            DispatchQueue.main.async {
                self.segmentationHandlers[imageSegmentationRequest] = completionHandler
            }
            
            let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation, options: [:])
            
            do {
                let requests: [VNRequest] = [imageSegmentationRequest]
                
                try handler.perform(requests)
            }
            catch let error as NSError {
                print("Failed: \(error)")
            }
        }
    }
    
    /// The completion handler method that Vision calls when it completes a request.
    /// - Parameters:
    ///   - request: A Vision request.
    ///   - error: An error if the request produced an error; otherwise `nil`.
    ///
    ///   The method checks for errors and validates the request's results.
    /// - Tag: visionRequestHandler
    private func visionRequestHandler(_ request: VNRequest, error: Error?) {
        // Remove the caller's handler from the dictionary and keep a reference to it.
        guard let segmentationHandler = segmentationHandlers.removeValue(forKey: request) else {
            fatalError("Every request must have a segmentation handler.")
        }
        
        // Start with a `nil` value in case there's a problem.
        var segmentations: [Segmentation]? = nil

        // Call the client's completion handler after the method returns.
        defer {
            // Send the segmentation back to the client.
            segmentationHandler(segmentations)
        }

        // Check for an error first.
        if let error = error {
            print("Vision image classification error...\n\n\(error.localizedDescription)")
            return
        }

        // Check that the results aren't `nil`.
        if request.results == nil {
            print("Vision request had no results.")
            return
        }

        guard let observations = request.results as? [VNCoreMLFeatureValueObservation] else {
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        
        guard let segmentationMap = observations.first?.featureValue.multiArrayValue else {
            print("Observation result does not contain multi array")
            return
        }
        
        // convert to nicer MultiArray type
        var mSegMap = MultiArray<Float32>(segmentationMap)
        var segMask = MultiArray<Float32>(shape: [128, 128])
        
        print(mSegMap.count)
        
        for w in 0..<128 {
            for h in 0..<128 {
                if mSegMap[0,w,h,0] > mSegMap[0,w,h,1] {
                    segMask[w,h] = 255
                } else {
                    segMask[w,h] = 0
                }
            }
        }
        
        // Convert MLMultiArray to image
        guard let segmentationImage: UIImage = segMask.array.image() else {
            print("Segmentation multiarray cannot be converted to cgImage")
            return
        }
        
        // Create a segmentation array from the observations.
        segmentations = observations.map { observation in
            // Convert each observation into an `SegmentationModel.Segmentation` instance.
            Segmentation(segmentationImage: segmentationImage, confidencePercentage: observation.confidence)
        }
    }
}
