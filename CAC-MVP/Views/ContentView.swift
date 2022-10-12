//
//  ContentView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            IslandView()
                .tabItem {
                    Image(systemName: "globe.americas.fill")
                }
            MealsView()
                .tabItem {
                    Image(systemName: "fork.knife")
                }
            CameraView()
                .tabItem {
                    Image(systemName: "camera")
                }
            GroceriesView()
                .tabItem {
                    Image(systemName: "bag.fill")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
