//
//  Model.swift
//  CameraPrototype
//
//  Created by Sabrina on 7/25/22.
//

import Foundation
import UIKit
import Vision

let stopwords : Set<String> = {
    if let path = Bundle.main.path(forResource: "stopwords", ofType: "txt") {
        do {
            let contents = try String(contentsOfFile: path)
            let modifiedContents : [String] = contents.lowercased().split(separator: "\n").map {String($0)}
            return Set<String>(modifiedContents)
        }
        catch {
            print("Error! Reading from file failed")
            return Set<String>()
        }
    } else {
        print("Error! Stopwords not found")
        return Set<String>()
    }
}()

class RowObservation : Identifiable {
    var id: String
    var textObservations = [TextObservation]()
    var boundingBox : CGRect
    
    init(observations: [TextObservation], boundingBox: CGRect) {
        id = UUID().uuidString
        textObservations = observations
        self.boundingBox = boundingBox
        
        for observation in observations {
            observation.row = self
        }
    }
}

class TextObservation : Identifiable {
    var id: String
    var text: String = ""
    var boundingBox : CGRect
    var row : RowObservation? = nil
    
    init(text : String, boundingBox : CGRect) {
        id = UUID().uuidString
        self.text = text
        self.boundingBox = boundingBox
    }
}

class ScanItem: Identifiable {
    var id: String
    var fullText: String = ""
    var image: UIImage?
    var rowObservations = [RowObservation]()
    var observations = [TextObservation]()
    var productNames = [String]()
    
    init() {
        id = UUID().uuidString
    }
}

class RecognizedContent: ObservableObject {
    @Published var items = [ScanItem]()
}
