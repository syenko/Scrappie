//
//  GroceryData.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct GroceryData {
    static var items: [GroceryItem] = [GroceryItem(name: "Food", dateAdded: .now), GroceryItem(name: "Food 2", dateAdded: .distantFuture)]
}
