//
//  MealsView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct MealsView: View {
    @EnvironmentObject var controller: ViewController
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
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(controller.meals.mealList, id: \.self) { meal in
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
                            .clipShape(RoundedRectangle(cornerRadius: 25))
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 25)
//                                    .strokeBorder(Color.blue, lineWidth: 3)
//                            }
                            .padding(.horizontal)
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
            .environmentObject(ViewController())
    }
}
