//
//  MealData.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct MealData {
    var mealList: [MealItem] = [MealItem(dateAdded: .now, percent: 0.58, pointsEarned: 10),
                                       MealItem(dateAdded: .distantFuture, percent: 1.0, pointsEarned: 100),
                                       MealItem(dateAdded: .distantPast, percent: 0.1, pointsEarned: 20)]
}
