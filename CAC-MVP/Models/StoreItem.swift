//
//  StoreItem.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import Foundation
import SwiftUI

class StoreItem: Identifiable {
    var id = UUID()
    var assetName : String? = nil
    var price : Int
    var label: String? = nil
    var level: Int // ranges from 0 to 3 (usually), lower means lower level -> more easily unlocked
    
    var purchased : Bool = false
    var unlocked: Bool = false
    var selected: Bool = false
    
    var image: Image? {
        if let unwrappedName = assetName {
            return Image(unwrappedName)
        } else {
            return nil
        }
    }
    
    private var iconImage: Image {
        if let unwrappedName = assetName {
            return Image(unwrappedName)
        } else {
            return Image(systemName: "slash.circle")
        }
    }
    
    @ViewBuilder
    var icon: some View {
        ZStack {
            iconImage
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity((unlocked && purchased) ? 0 : 0.4))
            
            // Not unlockable (purchasable) yet
            if (!unlocked) {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            // able to be purchased, but not purchased yet
            else if (!purchased) {
                VStack {
                    Spacer()
                    Text("$ \(price)")
                        .foregroundColor(.white)
                }
                .padding(.bottom)
                .frame(width: 100, height: 100)
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
    
    init(id: UUID = UUID(), assetName: String? = nil, price: Int, label: String? = nil, level: Int, purchased: Bool = false, unlocked: Bool = false) {
        self.id = id
        self.assetName = assetName
        self.price = price
        self.label = label
        self.level = level
        self.purchased = purchased
        self.unlocked = unlocked
        
        self.unlocked = self.unlocked || self.purchased || self.selected
    }
    
    init(id: UUID = UUID(), assetName: String? = nil, label: String? = nil, level: Int, purchased: Bool = false, unlocked: Bool = false) {
        self.id = id
        self.assetName = assetName
        self.label = label
        self.level = level
        self.purchased = purchased
        self.unlocked = unlocked
        
        self.price = Constants.pricesPerLevel[level]
        self.unlocked = self.unlocked || self.purchased || self.selected
    }
    
    
}
