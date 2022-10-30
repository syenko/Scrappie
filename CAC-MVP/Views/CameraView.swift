//
//  CameraView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct CameraView: View {
    @EnvironmentObject var controller : ViewController
    var body: some View {
        switch (controller.cameraViewState) {
        case .notCameraPage:
            switch (controller.oldSelectedItem) {
            case 1:
                IslandView()
                    .environmentObject(controller)
            case 2:
                MealsView()
                    .environmentObject(controller)
            case 4:
                GroceriesView()
                    .environmentObject(controller)
            case 5:
                StatsView()
                    .environmentObject(controller)
            default:
                Text("Camera View")
            }
        case .receiptScanner:
            Text("Reciept Scanner goes here")
        case .foodScanner:
            Text("Food Scanner goes here")
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
            .environmentObject(ViewController())
    }
}
