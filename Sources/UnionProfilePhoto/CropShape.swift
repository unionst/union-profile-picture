//
//  CropShape.swift
//  UnionProfilePhoto
//
//  Created on 12/28/24.
//

import CropViewController

public enum CropShape {
    case circle
    case square
    
    var croppingStyle: CropViewCroppingStyle {
        switch self {
        case .circle: return .circular
        case .square: return .default
        }
    }
}

