//
//  ViewController.swift
//  CAC-MVP
//
//  Created by Vir Shah on 10/12/22.
//

import Foundation
import UIKit

enum CameraViewState {
    case notCameraPage
    case receiptScanner
    case foodScanner
}

class ViewController: ObservableObject {
    @Published var groceries = GroceryData()
    @Published var meals = MealData()
    @Published var island = IslandData()
    
    // Receipt Scanning
    @Published var recognizedContent = RecognizedContent()
    
    // Food Scanning
    @Published var selectedImage : UIImage? = nil
    @Published var segmentationImage : UIImage? = nil
    
    // CameraView
    @Published var cameraViewState : CameraViewState = .notCameraPage
    
    // TabView
    @Published var selectedItem = 1
    @Published var oldSelectedItem = 1
    
    func getMeals() -> Int {
        return meals.mealList.count
    }
}
