//
//  ItemCollection.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import Foundation

class ItemCollection {
    var items: [StoreItem]
    
    var _selectedItem: StoreItem
    var selectedItem: StoreItem {
        get {
            return self._selectedItem
        }
        set {
            _selectedItem = newValue
            
            for (index, it) in items.enumerated() {
                if (it.id != _selectedItem.id) {
                    items[index].selected = false
                }
                else {
                    items[index].selected = true
                }
            }
        }
    }
    var level: Int = 0
    
    init(items: [StoreItem], selectedItemIndex: Int) {
        self.items = items
        self._selectedItem = self.items[selectedItemIndex]
        
        unlockItems()
    }
    
    init(items: [StoreItem]) {
        self.items = items
        
        self._selectedItem = self.items[0]
        
        selectedItem.selected = true
        unlockItems()
    }
    
    init(assetNames: [String?], itemPrices: [Int], itemLabels: [String], itemLevels: [Int]) {
        items = [StoreItem]()
        
        for (index, assetName) in assetNames.enumerated() {
            items.append(StoreItem(assetName: assetName, price: itemPrices[index], label: itemLabels[index], level: itemLevels[index]))
        }
        
        items[0].purchased = true;
        self._selectedItem = items[0]
        
//        selectedItem.selected = true
        unlockItems()
    }
    
    func unlockItems() {
        for i in 0..<items.count {
            if (items[i].level <= self.level + 1) {
                items[i].unlocked = true
            }
        }
    }
    
    private func selectItem(item: StoreItem) {
        for (index, it) in items.enumerated() {
            if (it.id != item.id) {
                items[index].selected = false
            }
            else {
                items[index].selected = true
            }
        }
    }
    
    func purchaseItem(item: StoreItem) -> Bool {
        // check to see if the item's able to be purchased yet or already purchased
        if (!item.unlocked || item.purchased) {
            return false
        }
        
        item.purchased = true
        
        level = max(self.level, item.level)
        unlockItems()
        
        return true
    }
}
