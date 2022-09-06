//
//  MealItem.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct MealItem: Identifiable, Hashable {
    var id = UUID()
    var dateAdded: Date
    var percent: Double
    var pointsEarned: Int
}
