//
//  ViewController.swift
//  CAC-MVP
//
//  Created by Vir Shah on 10/12/22.
//

import Foundation

class ViewController: ObservableObject {
    @Published var groceries = GroceryData()
    @Published var meals = MealData()
    @Published var island = IslandData()
    
    
    func getMeals() -> Int {
        return meals.mealList.count
    }
}
