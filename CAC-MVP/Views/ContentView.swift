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
    
    // Camera view
    @State private var isRecognizing : Bool = false
    @State private var showingScanner = false
    
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
        .confirmationDialog("", isPresented: $showActionSheet, titleVisibility: .hidden) {
            Button("Scan Receipts") {
                showingScanner = true
                viewController.cameraViewState = .receiptScanner
            }
            Button("Scan Food") {
                viewController.cameraViewState = .foodScanner
            }
            Button("Cancel", role: .cancel) {
                viewController.selectedItem = viewController.oldSelectedItem
                viewController.cameraViewState = .notCameraPage
            }
        }
        .sheet(isPresented: $showingScanner) {
            ScannerView { result in
                switch result {
                    case .success(let scannedImages):
                        isRecognizing = true
                    TextRecognition(scannedImages: scannedImages, recognizedContent: viewController.recognizedContent) {
                            isRecognizing = false
                            viewController.cameraViewState = .receiptScanner
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
        .onAppear {
//            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
