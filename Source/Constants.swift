//
//  Constants.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 17/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

public enum AnimationType {
    case holeBall1
    case holeBall2
    case holeBall3
    
    var tabView: AnimatedTabView {
        get {
            switch self {
            case .holeBall1:
                return HoleScaleTabView()
            case .holeBall2:
                return InvertedPlateauTabView()
            case .holeBall3:
                return MorphPlateauTabView()
            }
        }
    }
}

struct SETimingFunction {
    public static let seEaseIn = CAMediaTimingFunction(controlPoints: 0.6, 0, 1, 1)
    public static let seEaseOut = CAMediaTimingFunction(controlPoints: 0, 0, 0.4, 1)
    public static let seEaseInOut = CAMediaTimingFunction(controlPoints: 0.6, 0, 0.4, 1)
}
