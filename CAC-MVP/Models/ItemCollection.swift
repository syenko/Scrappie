//
//  ItemCollection.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import Foundation

struct ItemCollection {
    var items: [StoreItem]
    var selectedItem: StoreItem
    var level: Int = 0
    
    init(items: [StoreItem], selectedItemIndex: Int) {
        self.items = items
        self.selectedItem = self.items[selectedItemIndex]
    }
    
    init(items: [StoreItem]) {
        self.items = items
        
        selectedItem = self.items[0]
    }
    
    init(assetNames: [String?], itemPrices: [Int], itemLabels: [String], itemLevels: [Int]) {
        items = [StoreItem]()
        
        for (index, assetName) in assetNames.enumerated() {
            items.append(StoreItem(assetName: assetName, price: itemPrices[index], label: itemLabels[index], level: itemLevels[index]))
        }
        
        items[0].unlocked = true;
        selectedItem = items[0]
    }
}
