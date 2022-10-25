//
//  StreaksView.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import SwiftUI

struct StreaksView: View {
    var body: some View {
        VStack {
            // TODO: Link to actual data, display past streaks, highest streak
            Image(systemName: "flame")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundStyle(LinearGradient(colors: [.red,.orange], startPoint: .zero, endPoint: .trailing))
                .padding(.all)
            
            Text("3 Day Streak!")
                .font(.title)
                .foregroundStyle(LinearGradient(colors: [.red,.orange], startPoint: .zero, endPoint: .trailing))
        }
        .navigationTitle("Streaks")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StreaksView_Previews: PreviewProvider {
    static var previews: some View {
        StreaksView()
    }
}
