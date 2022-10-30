//
//  CGIImagePropertyOrientation+UIImageOrientationInit.swift
//  CameraPrototype
//
//  Created by Sabrina on 7/25/22.
//

import Foundation
import SwiftUI

// From here: https://developer.apple.com/documentation/imageio/cgimagepropertyorientation
extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}
