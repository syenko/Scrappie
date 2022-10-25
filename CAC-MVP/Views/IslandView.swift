//
//  IslandView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct CircleButton: View {
    let imageName: String
    var body: some View {
        ZStack {
            Circle().frame(width: 55, height: 55, alignment: .center)
            Circle().frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.white)
            Image(systemName: self.imageName)
            
        }
    }
}

struct IslandView: View {
    @EnvironmentObject var controller: ViewController
    @State var showingStreaks: Bool = false
    @State var showingHelp: Bool = false
    @State var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Source: https://stackoverflow.com/questions/57130866/how-to-show-navigationlink-as-a-button-in-swiftui
                NavigationLink(destination: ShopView(), tag: 1, selection: $action) {
                    EmptyView()
                }
                NavigationLink(destination: StreaksView(), tag: 2, selection: $action) {
                    EmptyView()
                }
                NavigationLink(destination: HelpView(), tag: 3, selection: $action) {
                    EmptyView()
                }
                
                if let skyImage = controller.island.skiesCollection.selectedItem.image {
                    skyImage
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                
                if let groundImage = controller.island.groundCollection.selectedItem.image {
                    groundImage
                        .resizable()
                        .ignoresSafeArea()
                }
                
                if let flowerImage = controller.island.flowerCollection.selectedItem.image {
                    flowerImage
                        .resizable()
                }
                
                if let pondImage = controller.island.pondCollection.selectedItem.image {
                    pondImage
                        .resizable()
                }
                
                Image("leaf1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.5)
                
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Button {
                            action = 2
                        } label: {
                            CircleButton(imageName: "number")
                        }
                        Button {
                            action = 1
                        } label: {
                            CircleButton(imageName: "gift")
                        }
                        Button {
                            action = 3
                        } label: {
                            CircleButton(imageName: "questionmark")
                        }
                        Spacer()
                    }.padding(.trailing)
                }.padding(.horizontal)
                
            }
        }
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
            .environmentObject(ViewController())
    }
}
