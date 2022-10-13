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
    @State var showingStreaks: Bool = false
    @State var showingHelp: Bool = false
    
    var body: some View {
        ZStack {
            Image("sky1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("pond3")
                .resizable()
                
            Image("leaf1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.5)
            
            HStack {
                Spacer()
                VStack(spacing: 10) {
                    Button {
                        showingStreaks.toggle()
                    } label: {
                        CircleButton(imageName: "number")
                    }
                    CircleButton(imageName: "gift")
                    Button {
                        showingHelp = true
                    } label: {
                        CircleButton(imageName: "questionmark")
                    }
                    Spacer()
                }.padding(.trailing)
            }
            
            if showingStreaks {
                GroupBox {
                    HStack {
                        Text("Highest:")
                        Spacer()
                        Text("10").monospacedDigit()
                            .font(.title)
                    }
                    Image(systemName: "chart.bar.xaxis")
                        .font(.system(size: 100))
                    HStack() {
                        Spacer()
                        CircleButton(imageName: "square.fill")
                        Spacer()
                        CircleButton(imageName: "play.fill")
                        Spacer()
                    }.scaleEffect(0.7)
                } label: {
                    HStack {
                        Label("1 Week Streak!", systemImage: "flame")
                            .font(.title2)
                            .foregroundStyle(LinearGradient(colors: [.red,.orange], startPoint: .zero, endPoint: .trailing))
                        Spacer()
                        Button {
                           showingStreaks = false
                        } label: {
                            Image(systemName: "x.circle")
                                .padding()
                        }
                    }
                }.frame(maxWidth:300)
            }
            
            
        }.popover(isPresented: $showingHelp) {
            Text("Please contact your local officials for any help required.")
        }
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
    }
}
