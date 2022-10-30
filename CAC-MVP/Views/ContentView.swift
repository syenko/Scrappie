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
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1
    @State private var showActionSheet = false
    
    var body: some View {
        TabView(selection: $selectedItem) {
            IslandView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "globe.americas.fill")
                }
                .tag(1)
                .onAppear {
                    self.oldSelectedItem = self.selectedItem
                }
            MealsView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "fork.knife")
                }
                .tag(2)
                .onAppear {
                    self.oldSelectedItem = self.selectedItem
                }
            IslandView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "camera")
                }
                .tag(3)
                .onAppear {
                    self.selectedItem = self.oldSelectedItem
                    self.showActionSheet.toggle()
                }
            GroceriesView()
                .tabItem {
                    Image(systemName: "bag.fill")
                }
                .tag(4)
                .onAppear {
                    self.oldSelectedItem = self.selectedItem
                }
            StatsView()
                .environmentObject(viewController)
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
                .tag(5)
                .onAppear {
                    self.oldSelectedItem = self.selectedItem
                }
        }
        .confirmationDialog("", isPresented: $showActionSheet, titleVisibility: .hidden) {
            Button("Scan Receipts") {
                
            }
            Button("Scan Food") {
                
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
