//
//  StoreItem.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import Foundation
import SwiftUI

struct StoreItem: Identifiable {
    var id = UUID()
    var assetName : String? = nil
    var price : Int
    var label: String? = nil
    var level: Int // ranges from 0 to 3 (usually), lower means lower level -> more easily unlocked
    
    var unlocked : Bool = false
    var unlockable: Bool = false
    
    var image: Image? {
        if let unwrappedName = assetName {
            return Image(unwrappedName)
        } else {
            return nil
        }
    }
    
    var icon: Image {
        if let unwrappedName = assetName {
            return Image(unwrappedName)
        } else {
            return Image(systemName: "slash.circle")
        }
    }
    
    init(id: UUID = UUID(), assetName: String? = nil, price: Int, label: String? = nil, level: Int, unlocked: Bool = false, unlockable: Bool = false) {
        self.id = id
        self.assetName = assetName
        self.price = price
        self.label = label
        self.level = level
        self.unlocked = unlocked
        self.unlockable = unlockable
    }
    
    init(id: UUID = UUID(), assetName: String? = nil, label: String? = nil, level: Int, unlocked: Bool = false, unlockable: Bool = false) {
        self.id = id
        self.assetName = assetName
        self.label = label
        self.level = level
        self.unlocked = unlocked
        self.unlockable = unlockable
        
        self.price = level * 100
    }
}
