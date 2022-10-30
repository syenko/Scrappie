//
//  TextRecognition.swift
//  CameraPrototype
//
//  Created by Sabrina on 7/25/22.
//
//  From: https://www.appcoda.com/swiftui-text-recognition/

import SwiftUI
import Vision
import Foundation

struct TextRecognition {
    var scannedImages: [UIImage]
    @ObservedObject var recognizedContent: RecognizedContent
    var didFinishRecognition: () -> Void
    
    private func getTextRecognitionRequest(with scanItem: ScanItem) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            // handle error
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // load observations
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("Recieved invalid observations")
                return
            }
            
            // take out text from observations
            for observation in observations {
                // pull the best candidate for a text string (what the Vision framework thinks the text says)
                // bestCandidate is of type VNRecognizedText
                guard let bestCandidate = observation.topCandidates(1).first else {
                    print("No candidate")
                    continue
                }
                
                // print OCR text
//                print(bestCandidate.string)
                
                // add ocr text to textItem
                scanItem.fullText += "\(bestCandidate.string)\n"
                
//                print("(\(observation.boundingBox.midX), \(observation.boundingBox.midY))")
                
                // add text observation
                scanItem.observations.append(TextObservation(text: bestCandidate.string, boundingBox: observation.boundingBox))
            }
        }
        request.recognitionLevel = .accurate
        
        return request
    }
    
    func recognizeText() {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        queue.async {
            for image in scannedImages {
                // check to see if inputImage exists, otherwise exit
                guard let cgImage = image.cgImage else { return }
                
                // set up handler to process request
                let handler : VNImageRequestHandler
                // http://www.gfrigerio.com/text-recognition-with-vision/
                let orientation = image.imageOrientation
                handler = VNImageRequestHandler(cgImage: cgImage, orientation: CGImagePropertyOrientation(orientation), options: [:])
                
                do {
                    let scanItem = ScanItem()
                    scanItem.image = image
                    try handler.perform([getTextRecognitionRequest(with: scanItem)])
                    
                    // split text into rows
                    splitTextIntoRows(with: scanItem)
                    
                    // Scan rows and extract text
                    extractProductNames(from: scanItem)
                    
                    // Add scan item in main queue
                    DispatchQueue.main.async {
                        recognizedContent.items.append(scanItem)
                        print("--------")
                    }
                }
                catch let error as NSError {
                    print("Failed: \(error)")
                }
            }
            
            // let UI know textRecognition has finished
            DispatchQueue.main.async {
                didFinishRecognition()
            }
        }
    }
    
    // Row splitting functions
    private func dfs(node: Int, component: inout Set<Int>, visited: inout [Bool], graph: [[Int]]) {
        if (visited[node]) {
            return
        }
        visited[node] = true
        component.insert(node)
        
        for i in graph[node] {
            dfs(node: i, component: &component, visited: &visited, graph: graph)
        }
    }
    
    private func componentToRowObservation(component: Set<Int>, observations: [TextObservation]) -> RowObservation {
        var finalrect : CGRect = observations[Array(component)[0]].boundingBox
        var textObservations = [TextObservation]()
        
        for i in component {
            let rect = observations[i].boundingBox
            finalrect = finalrect.union(rect)
            textObservations.append(observations[i])
        }
        return RowObservation(observations: textObservations, boundingBox: finalrect)
    }
    
    private func splitTextIntoRows(with scanItem: ScanItem) {
        let yThreshhold = 0.004 // threshhold for y (how close they have to be)
        let n = scanItem.observations.count
        
        var pairs = [[Int]]()
        // find all pairs of nearby elements and merge them
        for i in 0..<n {
            for j in i..<n {
                let boxi : CGRect = scanItem.observations[i].boundingBox;
                let boxj : CGRect = scanItem.observations[j].boundingBox;
//                print("i's y: \(boxi.minY), j's y: \(boxj.minY)")
                let minYCheck = abs(boxi.minY - boxj.minY) < yThreshhold
                let maxYCheck = abs(boxi.maxY - boxj.maxY) < yThreshhold
                let midYCheck = abs(boxi.midY - boxj.midY) < yThreshhold
                if (minYCheck || maxYCheck || midYCheck) {
                    pairs.append([i, j])
                }
            }
        }
        print("Total observations: \(n) to number of pairs: \(pairs.count)");
        // dfs to find connected components
        var graph = Array(repeating: [Int](), count: n)
        for pair in pairs {
            let i : Int = pair[0]
            let j : Int = pair[1]
            graph[i].append(j)
            graph[j].append(i)
        }
        
        var visited = Array(repeating: false, count: n)
        var components = [Set<Int>]()
        for i in 0..<n {
            if !visited[i] {
                var component = Set<Int>()
                dfs(node: i, component: &component, visited: &visited, graph: graph)
                
                components.append(component)
            }
        }
        
        for component in components {
            scanItem.rowObservations.append(componentToRowObservation(component: component, observations: scanItem.observations))
        }
        
        
        print("num row observations: \(scanItem.rowObservations.count)" )
        print("split complete!!")
    }
    
    // Product extraction functions
    
    private func extractProductNames(from scanItem: ScanItem) {
        let priceRegex =  NSRegularExpression(#"\$*\d{0,3}[.,]\d{2}"#)
        
        for observation in scanItem.observations {
            // if price found
            if priceRegex.matches(observation.text) {
                
                // iterate through other observations in the row
                if let row = observation.row {
                    var text = ""
                    for nearObs in row.textObservations {
                        
                        // skip if price
//                        if nearObs.id == observation.id { continue }
                        
                        // get product name
                        if let productName = TextProcessing.extractProduct(nearObs.text) {
                            text += productName
                            text += " "
                        }
                    }
                    text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if (text.count > 0) {
                        scanItem.productNames.append(text)
                    }
                }
            }
        }
    }
}
