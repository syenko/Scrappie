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
    
    mutating func addMealFromDifference(before: Segmentation, after: Segmentation) -> Int {
        let percent = max(0, (before.foodPercentage - after.foodPercentage) / before.foodPercentage)
        let pointsEarned = Int(percent * 100)
        mealList.append(MealItem(dateAdded: .now, percent: percent, pointsEarned: pointsEarned))
        return pointsEarned
    }
}
