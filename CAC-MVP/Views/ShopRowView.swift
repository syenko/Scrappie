//
//  ShopRowView.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/30/22.
//

import SwiftUI

struct ShopRowView: View {
    @EnvironmentObject var controller : ViewController
    @State var collection: ItemCollection
    var name : String = "Test"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .padding(.leading)
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(collection.items, id: \.id) { storeItem in
                        storeItem.icon
                            .onTapGesture {
                                if (storeItem.purchased) {
                                    collection.selectedItem = storeItem
                                }
                                controller.island.purchaseItem(collection: &collection, item: storeItem)
                            }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct ShopRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShopRowView(collection: ViewController().island.skiesCollection)
            .environmentObject(ViewController())
    }
}
