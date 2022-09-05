//
//  IslandView.swift
//  CAC-MVP
//
//  Created by Vir Shah on 8/23/22.
//

import SwiftUI

struct IslandView: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        Circle().frame(width: 55, height: 55, alignment: .center)
                        Circle().frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.white)
                        Image(systemName: "number")

                    }
                    ZStack {
                        Circle().frame(width: 55, height: 55, alignment: .center)
                        Circle().frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color.white)
                        Image(systemName: "gift")

                    }
                    ZStack {
                        Circle().frame(width: 55, height: 55, alignment: .center)
                        Circle().frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color.white)
                        Image(systemName: "questionmark")

                    }
                    Spacer()
                }.padding(.trailing)
            }
            
            Text("Island")
        }
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
    }
}
