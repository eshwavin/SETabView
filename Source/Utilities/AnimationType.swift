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
    
    var tabView: AnimatedTabViewProtocol {
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
