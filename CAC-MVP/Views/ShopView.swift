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
                    .padding(.leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(controller.island.skiesCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                                .onTapGesture {
                                    if (storeItem.unlocked) {
                                        controller.island.skiesCollection.selectedItem = storeItem
                                    }
                                }
                        }
                    }
                }.padding(.bottom)
                
                Text("Ground")
                    .font(.headline)
                    .padding(.leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(controller.island.groundCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                                .onTapGesture {
                                    if (storeItem.unlocked) {
                                        controller.island.groundCollection.selectedItem = storeItem
                                    }
                                }
                        }
                    }
                }.padding(.bottom)
                
                Text("Pond")
                    .font(.headline)
                    .padding(.leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(controller.island.pondCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                                .onTapGesture {
                                    if (storeItem.unlocked) {
                                        controller.island.pondCollection.selectedItem = storeItem
                                    }
                                }
                        }
                    }
                }.padding(.bottom)
                
                Text("Flowers")
                    .font(.headline)
                    .padding(.leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(controller.island.flowerCollection.items, id: \.id) { storeItem in
                            storeItem.icon
                                .onTapGesture {
                                    if (storeItem.unlocked) {
                                        controller.island.flowerCollection.selectedItem = storeItem
                                    }
                                }
                        }
                    }
                }
                
                Spacer()
            }
        }
//        .padding(.leading)
        .navigationTitle("Shop")
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(ViewController())
    }
}
