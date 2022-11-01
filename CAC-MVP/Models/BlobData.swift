//
//  BlobData.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/31/22.
//

import Foundation

enum BlobNames : Int {
    case wings = 0
    case leaf = 1
    case fins = 2
    case horns = 3
    case flower = 4
    case ears = 5
}

struct BlobData {
    var numSelectedBlobs = 0
    
    var blobs : [Blob] = [
        Blob(assetPrefix: "wings", widthPaddingPercent: 0.2, heightPaddingPercent: 0.05),
        Blob(selected: true, assetPrefix: "leaf", widthPaddingPercent: 0.3, heightPaddingPercent: 0.39),
        Blob(assetPrefix: "fins", widthPaddingPercent: 0.05, heightPaddingPercent: 0.5),
        Blob(assetPrefix: "horns", widthPaddingPercent: 0.4, heightPaddingPercent: 0.62),
        Blob(assetPrefix: "flower", widthPaddingPercent: 0, heightPaddingPercent: 0.75),
        Blob(assetPrefix: "ears", widthPaddingPercent: 0.6, heightPaddingPercent: 0.78)
    ]
}
