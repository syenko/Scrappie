//
//  GroceriesView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct GroceriesView: View {
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
                        .overlay {
                            if dateSorted {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.blue, lineWidth: 2)
                            }
                        }

                    Spacer()
                }.font(.headline)
                
                List {
                    ForEach(GroceryData.items.sorted(by: dateSorted ? { a, b in
                        a.dateAdded > b.dateAdded
                    } : {
                        a, b in a.name.lexicographicallyPrecedes(b.name)
                    }
                                                    
                                                    ), id: \.self) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(item.dateAdded.formatted(.dateTime).description)
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
    }
}
