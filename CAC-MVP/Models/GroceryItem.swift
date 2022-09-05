//
//  GroceryItem.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct GroceryItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var name: String
    var dateAdded: Date
}
