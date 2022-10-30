//
//  IslandData.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/22/22.
//

import Foundation

struct IslandData {
    var points : Int = 200
    
    // Island collections
    var skiesCollection = ItemCollection(items: [
        StoreItem(assetName: "skystart", level: 0, purchased: true),
        StoreItem(assetName: "sky1", level: 1),
        StoreItem(assetName: "sky2", level: 2),
        StoreItem(assetName: "sky3", level: 3),
        StoreItem(assetName: "night1", level: 1),
        StoreItem(assetName: "night2", level: 2),
        StoreItem(assetName: "night3", level: 3),
        StoreItem(assetName: "dusk1", level: 1),
        StoreItem(assetName: "dusk2", level: 2),
        StoreItem(assetName: "dusk3", level: 3),
    ])
    
    var groundCollection = ItemCollection(items: [
        StoreItem(assetName: "groundstart", level: 0, purchased: true),
        StoreItem(assetName: "ground1", level: 1),
        StoreItem(assetName: "ground2", level: 2),
        StoreItem(assetName: "ground3", level: 3),
    ])
    
    var pondCollection = ItemCollection(items: [
        StoreItem(assetName: "pondstart", level: 0, purchased: true),
        StoreItem(assetName: "pond1", level: 1),
        StoreItem(assetName: "pond2", level: 2),
        StoreItem(assetName: "pond3", level: 3),
    ])
    
    var flowerCollection = ItemCollection(items: [
        StoreItem(assetName: nil, level: 0, purchased: true),
        StoreItem(assetName: "flowers1", level: 1),
        StoreItem(assetName: "flowers2", level: 2),
        StoreItem(assetName: "flowers3", level: 3),
    ])
    
    mutating func purchaseItem(collection: inout ItemCollection, item: StoreItem) -> Bool {
        // check to see if it's possible to make the purchase
        if (item.price > self.points) {
            return false
        }
        if (collection.purchaseItem(item: item)) {
            self.points -= item.price
            return true
        }
        return false
    }
}
