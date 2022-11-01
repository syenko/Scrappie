//
//  ContentView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var viewController = ViewController()
    
    // Source: https://stackoverflow.com/questions/60394201/tabbar-middle-button-utility-function-in-swiftui
    @State private var showActionSheet = false
    @State private var showMealActionSheet = false
    
    // Receipt Scanner view
    @State private var isRecognizing = false
    @State private var showingScanner = false
    @State private var showingScannerAlert = false
    
    // Food Camera
    @State private var showingImagePicker = false;
    @State private var showingFoodAlert = false
    
    var body: some View {
        TabView(selection: $viewController.selectedItem) {
            IslandView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "globe.americas.fill")
                }
                .tag(1)
                .onAppear {
                    viewController.cameraViewState = .notCameraPage
                    viewController.oldSelectedItem = viewController.selectedItem
                }
            MealsView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "fork.knife")
                }
                .tag(2)
                .onAppear {
                    viewController.cameraViewState = .notCameraPage
                    viewController.oldSelectedItem = viewController.selectedItem
                }
            CameraView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "camera")
                }
                .tag(3)
                .onAppear {
                    //                    self.selectedItem = self.oldSelectedItem
                    if (viewController.cameraViewState == .notCameraPage) {
                        self.showActionSheet = true
                    }
                }
            GroceriesView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "bag.fill")
                }
                .tag(4)
                .onAppear {
                    viewController.cameraViewState = .notCameraPage
                    viewController.oldSelectedItem = viewController.selectedItem
                }
            StatsView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
                .tag(5)
                .onAppear {
                    viewController.cameraViewState = .notCameraPage
                    viewController.oldSelectedItem = viewController.selectedItem
                }
        }
        // Camera action sheet
        .confirmationDialog("", isPresented: $showActionSheet, titleVisibility: .hidden) {
            Button("Scan Receipt") {
                showingScanner = true
            }
            Button("Scan Meal") {
                showMealActionSheet = true
                //                showingImagePicker = true
            }
            Button("Cancel", role: .cancel) {
                viewController.selectedItem = viewController.oldSelectedItem
                viewController.cameraViewState = .notCameraPage
            }
        }
        .confirmationDialog("", isPresented: $showMealActionSheet, titleVisibility: .hidden
        ) {
            // first photo has not been taken yet
            if (viewController.beforeSegmentation == nil) {
                Button("Take \"Before\" Photo") {
                    viewController.mealScannerState = MealScannerState.beforePhoto
                    showingImagePicker = true
                }
            }
            else {
                Button("Retake \"Before\" Photo") {
                    viewController.mealScannerState = MealScannerState.beforePhoto
                    showingImagePicker = true
                }
                Button("Take \"After\" Photo") {
                    viewController.mealScannerState = MealScannerState.afterPhoto
                    showingImagePicker = true
                }
            }
            Button("Cancel", role: .cancel) {
                viewController.selectedItem = viewController.oldSelectedItem
                viewController.cameraViewState = .notCameraPage
            }
        }
        // Receipt Scanner Sheet
        .sheet(isPresented: $showingScanner) {
            ScannerView { result in
                switch result {
                case .success(let scannedImages):
                    isRecognizing = true
                    TextRecognition(scannedImages: scannedImages, recognizedContent: viewController.recognizedContent) {
                        // Add recognized items to groceries
                        viewController.addProductsFromScannedReceipt(recognizedContent: viewController.recognizedContent)
                        
                        isRecognizing = false
                        showingScannerAlert = true
                    }
                    .recognizeText()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                showingScanner = false
            } didCancelScanning: {
                // dismiss scanner
                showingScanner = false
                viewController.selectedItem = viewController.oldSelectedItem
            }
        }
        .alert("Receipt scanned successfully!", isPresented: $showingScannerAlert) {
            Button("OK", role: .cancel) {
                viewController.selectedItem = 4
            }
        } message: {
            Text("You earned \(viewController.lastPointsEarned) points!")
        }
        // Food Camera Sheet
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker() { result in
                switch result {
                case .success(let image):
                    viewController.selectedImage = image
                    
                    // Use ML Model
                    ImageSegmentation().makePredictions(for: viewController.selectedImage!) { segmentations in
                        guard let segmentation = segmentations?.first else {
                            return
                        }
                        DispatchQueue.main.async {
                            switch(viewController.mealScannerState) {
                            case .beforePhoto:
                                viewController.beforeSegmentation = segmentation
                            case .afterPhoto:
                                viewController.afterSegmentation = segmentation
                                viewController.addMeal()
                            }
                            viewController.segmentationImage = segmentation.segmentationImage
                            showingFoodAlert = true
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                showingImagePicker = false
            } didCancelGettingImage: {
                showingImagePicker = false
                viewController.selectedItem = viewController.oldSelectedItem
            }
        }
        .alert("Meal logged sucessfully!", isPresented: $showingFoodAlert) {
            Button("OK", role: .cancel) {
                switch(viewController.mealScannerState) {
                case .beforePhoto:
                    viewController.selectedItem = viewController.oldSelectedItem
                case .afterPhoto:
                    viewController.selectedItem = 2
                }
            }
        } message: {
            switch(viewController.mealScannerState) {
            case .beforePhoto:
                Text("First photo taken!")
            case .afterPhoto:
                Text("Nice job! You cleared about \(viewController.lastPointsEarned)% of your plate, earning \(viewController.lastPointsEarned) points.")
            }
        }
        .alert(viewController.badgeAlertTitle, isPresented: $viewController.showingBadgeAlert) {
            if (viewController.selectedItem != 1) {
                Button("Go to Island") {
                    viewController.selectedItem = 1
                }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewController.badgeAlertMessage)
        }
        .onAppear {
//            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
