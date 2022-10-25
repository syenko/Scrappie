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
                Text("Sky")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(controller.island.skiesCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                                .onTapGesture {
                                    controller.island.skiesCollection.selectedItem = storeItem
                                }
                        }
                    }
                }.padding(.bottom)
                
                Text("Ground")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(controller.island.groundCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                        }
                    }
                }.padding(.bottom)
                
                Text("Pond")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(controller.island.pondCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                        }
                    }
                }.padding(.bottom)
                
                Text("Flowers")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(controller.island.flowerCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(.all)
        .navigationTitle("Shop")
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(ViewController())
    }
}
