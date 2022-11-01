//
//  Blob.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/31/22.
//

import Foundation
import SwiftUI

struct Blob : Identifiable {
    var id = UUID()
    
    var selected = false
    var unlocked = false
    
    var assetPrefix : String
    var color: Color
    var level = 1
    
    var widthPaddingPercent : Double
    var heightPaddingPercent : Double
    
    var curImageName : String {
        if (level == 0) {
            return "z"
        }
        else {
            return "\(assetPrefix)\(level)"
        }
    }
    
    @ViewBuilder
    var icon: some View {
        ZStack {
            if (level == 0) {
                color
                    .overlay(Color.black.opacity(0.1))
            }
            Image(curImageName)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(unlocked ? 0 : 0.2))
            
            // Not unlocked yet
            if (!unlocked) {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .strokeBorder(.blue, lineWidth: self.selected ? 3 : 0)
        )
        .padding(.leading, 10)
    }
    
}
