//
//  BlobData.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/31/22.
//

import Foundation
import SwiftUI

enum BlobNames : Int {
    case leaf = 0
    case wings = 1
    case fins = 2
    case horn = 3
    case flower = 4
    case ears = 5
}

struct BlobData {
    var numSelectedBlobs = 1
    
    var blobs : [Blob] = [
        Blob(selected: true, assetPrefix: "leaf", color: Color("Leaf"), widthPaddingPercent: 0.3, heightPaddingPercent: 0.39),
        Blob(assetPrefix: "wings", color: Color("Wings"), widthPaddingPercent: 0.2, heightPaddingPercent: 0.05),
        Blob(assetPrefix: "fins", color: Color("Fins"), widthPaddingPercent: 0.05, heightPaddingPercent: 0.5),
        Blob(assetPrefix: "horn", color: Color("Horn"), widthPaddingPercent: 0.4, heightPaddingPercent: 0.62),
        Blob(assetPrefix: "flower", color: Color("Flower"), widthPaddingPercent: 0, heightPaddingPercent: 0.75),
        Blob(assetPrefix: "ears", color: Color("Ears"), widthPaddingPercent: 0.6, heightPaddingPercent: 0.78)
    ]
    
    mutating func toggleSelectBlob(blob : Blob) {
        if (!blob.unlocked) { return }
        
        if (blob.selected) {
            for (index, b) in blobs.enumerated() {
                if (b.id == blob.id) {
                    blobs[index].selected = false
                }
            }
            numSelectedBlobs -= 1
            return
        }
        
        if (numSelectedBlobs < 3) {
            for (index, b) in blobs.enumerated() {
                if (b.id == blob.id) {
                    blobs[index].selected = true
                }
            }
            numSelectedBlobs += 1
            return
        }
    }
}
