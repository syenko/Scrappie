//
//  ShopView.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject var controller : ViewController
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ShopRowView(collection: controller.island.skiesCollection, name: "Sky")
                    .environmentObject(controller)
                
                ShopRowView(collection: controller.island.groundCollection, name: "Ground")
                    .environmentObject(controller)
               
                ShopRowView(collection: controller.island.pondCollection, name: "Pond")
                    .environmentObject(controller)
               
                ShopRowView(collection: controller.island.flowerCollection, name: "Flowers")
                    .environmentObject(controller)
               
                Spacer()
            }
        }
        .navigationTitle("Island Customization")
        .toolbar {
            ToolbarItemGroup(placement:.navigationBarTrailing) {
                Text("$\(controller.island.points)")
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(ViewController())
    }
}
