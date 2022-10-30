//
//  GroceryData.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct GroceryData {
    var items: [GroceryItem] = [GroceryItem(name: "Food", dateAdded: .now), GroceryItem(name: "Food 2", dateAdded: .distantFuture)]
    
    mutating func addProductsFromScannedReceipt(recognizedContent: RecognizedContent) {
        for scanItem in recognizedContent.items {
            for name in scanItem.productNames {
                print(name)
                items.append(GroceryItem(name: name, dateAdded: .now))
            }
        }
    }
}
