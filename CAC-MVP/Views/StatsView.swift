//
//  StatsView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var controller: ViewController
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.title)
            Text("Total meals: \(controller.getMeals())")
            Text("Avg %: \(controller.meals.mealList.reduce(0, { x, y in x + y.percent}) / Double(controller.getMeals()))")
            Text("Amt food saved:")
            Text("Total receipts:")
            Text("Total items:")
            Text("Total points earned: \(controller.meals.mealList.reduce(0, {x, y in x + y.pointsEarned}))")
            Text("Total points spent: 0")
        }.font(.title2)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(ViewController())
    }
}
