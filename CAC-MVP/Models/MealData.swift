//
//  MealData.swift
//  CAC-MVP
//
//  Created by Vir Shah on 9/4/22.
//

import Foundation

struct MealData {
    var mealList: [MealItem] = [MealItem(dateAdded: Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now, percent: 0.58, pointsEarned: 58),
                                MealItem(dateAdded: Calendar.current.date(byAdding: .day, value: -2, to: .now) ?? .now, percent: 0.87, pointsEarned: 87),
                                       MealItem(dateAdded: Calendar.current.date(byAdding: .day, value: -3, to: .now) ?? .now, percent: 0.2, pointsEarned: 20)]
    
    var numMeals : Int {
        return mealList.count
    }
    
    mutating func addMealFromDifference(before: Segmentation, after: Segmentation) -> Int {
        let percent = max(0, (before.foodPercentage - after.foodPercentage) / before.foodPercentage)
        let pointsEarned = Int(percent * 100)
        mealList.append(MealItem(dateAdded: .now, percent: percent, pointsEarned: pointsEarned))
        return pointsEarned
    }
}
