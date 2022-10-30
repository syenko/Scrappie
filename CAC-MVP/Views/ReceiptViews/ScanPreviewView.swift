//
//  ScanPreviewView.swift
//  CameraPrototype
//
//  Created by Sabrina on 7/25/22.
//
//  View that represents a single scanned receipt

import SwiftUI
import CoreGraphics

struct ScanPreviewView : View {
    var scanItem : ScanItem
    
    var body: some View {
        
        List{
            ForEach(scanItem.productNames, id: \.self) { name in
                Text("\(name)")
            }
            Section {
                if let img = scanItem.image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        // Based on this: https://medium.com/swlh/how-to-draw-bounding-boxes-with-swiftui-d93d1414eb00
                        .overlay(
                            GeometryReader { geometry in
                                ForEach(scanItem.rowObservations, id: \.id) { observation in
                                    Rectangle()
                                        .path(in: CGRect(
                                            x: observation.boundingBox.minX * geometry.size.width,
                                            y: geometry.size.height - observation.boundingBox.minY * geometry.size.height - observation.boundingBox.height * geometry.size.height,
                                            width: observation.boundingBox.width * geometry.size.width,
                                            height: observation.boundingBox.height * geometry.size.height
                                        ))
                                        .stroke(Color.red)
                                }
                            }
                        )
                }
                Section {
                    Text(scanItem.fullText)
                        .font(.body)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
