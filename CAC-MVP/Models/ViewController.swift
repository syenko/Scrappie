//
//  ViewController.swift
//  CAC-MVP
//
//  Created by Vir Shah on 10/12/22.
//

import Foundation

class ViewController: ObservableObject {
    var groceries = GroceryData()
    var meals = MealData()
    
    func getMeals() -> Int {
        return meals.mealList.count
    }
}
