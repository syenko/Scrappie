//
//  GroceriesView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct GroceriesView: View {
    @EnvironmentObject var controller : ViewController
    
    @State private var itemsSorted: Bool = false
    @State private var dateSorted: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dateSorted = false
                        itemsSorted.toggle()
                    } label: {
                        Label("Items", systemImage: "arrow.up.arrow.down.circle")
                    }.buttonStyle(.bordered)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay {
                            if itemsSorted {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.blue, lineWidth: 2)
                            }
                        }
                    Spacer()
                    Button {
                       itemsSorted = false
                        dateSorted.toggle()
                    } label: {
                        Label("Date Added", systemImage: "arrow.up.arrow.down.circle")
                    }.buttonStyle(.bordered)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay {
                            if dateSorted {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.blue, lineWidth: 2)
                            }
                        }

                    Spacer()
                }.font(.headline)
                
                List {
                    ForEach(controller.groceries.items.sorted(by: dateSorted ? { a, b in
                        a.dateAdded < b.dateAdded
                    } : {
                        a, b in a.name.lexicographicallyPrecedes(b.name)
                    }
                                                    
                                                    ), id: \.self) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            let distFromToday = Calendar.current.dateComponents([.day], from: item.dateAdded, to: .now).day ?? 0
                            let text = distFromToday == 0 ? "Today" : distFromToday == 1 ? "\(distFromToday) day old" : "\(distFromToday) days old"
                            Text(text)
                                .foregroundColor(distFromToday > 6 ? .red :  distFromToday > 3 ? .yellow : .black)
                        }
                    }
                }
                    .navigationTitle("Groceries")
                Spacer()
                
            }
        }
    }
}

struct GroceriesView_Previews: PreviewProvider {
    static var previews: some View {
        GroceriesView()
            .preferredColorScheme(.dark)
            .environmentObject(ViewController())
    }
}
