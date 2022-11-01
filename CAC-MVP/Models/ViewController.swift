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

enum MealScannerState {
    case beforePhoto
    case afterPhoto
}

class ViewController: ObservableObject {
    @Published var groceries = GroceryData()
    @Published var meals = MealData()
    @Published var island = IslandData()
    @Published var blobData = BlobData()
    
    // Receipt Scanning
    @Published var recognizedContent = RecognizedContent()
    
    // Food Scanning
    @Published var selectedImage : UIImage? = nil
    @Published var segmentationImage : UIImage? = nil
    
    @Published var mealScannerState : MealScannerState = .beforePhoto
    
    @Published var beforeSegmentation : Segmentation? = nil
    @Published var afterSegmentation : Segmentation? = nil
    
    // CameraView
    @Published var cameraViewState : CameraViewState = .notCameraPage
    
    // TabView
    @Published var selectedItem = 1
    @Published var oldSelectedItem = 1
    
    // Points
    @Published var lastPointsEarned = 0
    
    // Badge Alert
    @Published var showingBadgeAlert = false
    @Published var badgeAlertTitle = ""
    @Published var badgeAlertMessage = ""
    
    func getMeals() -> Int {
        return meals.mealList.count
    }
    
    func addProductsFromScannedReceipt(recognizedContent: RecognizedContent) {
        lastPointsEarned = groceries.addProductsFromScannedReceipt(recognizedContent: recognizedContent)
        island.points += lastPointsEarned
    }
    
    func addMeal() {
        guard let before = beforeSegmentation else {
            return
        }
        guard let after = afterSegmentation else {
            return
        }
        lastPointsEarned = meals.addMealFromDifference(before: before, after: after)
        island.points += lastPointsEarned
        
        beforeSegmentation = nil
        afterSegmentation = nil
        
        // check milestones
        for milestone in blobData.numMealMilestones {
            if (!milestone.achieved && meals.numMeals >= milestone.amount) {
                achievedMilestone(milestone)
            }
        }
    }
    
    func achievedMilestone(_ milestone: Milestone) {
        var mBlob = blobData.blobs[milestone.blob.rawValue]
        mBlob.level = milestone.level
        mBlob.unlocked = true
        
        if (blobData.numSelectedBlobs >= 3) {
            for blob in blobData.blobs {
                if (blob.selected) {
                    blobData.toggleSelectBlob(blob: blob)
                    break
                }
            }
        }
        
        blobData.toggleSelectBlob(blob: mBlob)
        
        badgeAlertTitle = milestone.title
        badgeAlertMessage = milestone.message
        showingBadgeAlert = true
    }
}
