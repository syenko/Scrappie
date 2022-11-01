//
//  GroceryData.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct GroceryData {
    var items: [GroceryItem] = [
        GroceryItem(name: "Hamburgers", dateAdded: .now),
        GroceryItem(name: "Pears", dateAdded: Calendar.current.date(byAdding: .day, value: -3, to: .now) ?? .now),
        GroceryItem(name: "String Cheese", dateAdded: Calendar.current.date(byAdding: .day, value: -5, to: .now) ?? .now),
        GroceryItem(name: "Apples", dateAdded: Calendar.current.date(byAdding: .day, value: -3, to: .now) ?? .now)
    ]
    
    mutating func addProductsFromScannedReceipt(recognizedContent: RecognizedContent) -> Int {
        var points = Constants.baseReceiptPoints
        for scanItem in recognizedContent.items {
            for name in scanItem.productNames {
                items.append(GroceryItem(name: name, dateAdded: .now))
                points += Constants.receiptItemsPoints
            }
        }
        return points
    }
}
