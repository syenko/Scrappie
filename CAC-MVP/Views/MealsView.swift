//
//  MealsView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct MealsView: View {
    var percentageColor = { (a: Double) -> Color in
        switch(a*100) {
        case 0...33:
            return Color.red
        case 34...66:
            return Color.orange
        default:
            return Color.green
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                Text("Status: Max Points Achieved")
                    .font(.headline)
                ScrollView {
                    VStack {
                        ForEach(MealData.mealList, id: \.self) { meal in
                            GroupBox {
                                HStack {
                                    Text("DATE:")
                                        .font(.headline)
                                    Spacer()
                                    Text(meal.dateAdded.formatted(.dateTime).description)
                                }
                                GeometryReader { reader in
                                    Path { path in
                                        path.move(to: .zero)
                                        path.addLine(to: CGPoint(x: reader.size.width, y: .zero))
                                    }.stroke(Color.gray.opacity(0.4), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [1], dashPhase: 10))
                                    Path { path in
                                        path.move(to: .zero)
                                        path.addLine(to: CGPoint(x: reader.size.width*meal.percent, y: .zero))
                                    }.stroke(percentageColor(meal.percent), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 2, dash: [1], dashPhase: 10))
                                }.padding(Edge.Set.top)
                                HStack {
                                    Text("Points Earned:".uppercased())
                                        .font(.headline)
                                    Spacer()
                                    Text(meal.pointsEarned.description)
                                        .monospacedDigit()
                                        .font(.title2)
                                        .bold()
                                }
                            }
                        }
                    }
                }
            }
                .navigationTitle("Scanned Meals")
        }
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
            .preferredColorScheme(.dark)
    }
}
