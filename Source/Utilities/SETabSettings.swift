//
//  SETabSettings.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 11/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class SETabSettings {
    
    static var current = SETabSettings()
    
    private init() {}
    
    var animationDuration: Double = 0.5
    
    var switchTabAnimationDuration: Double {
        return animationDuration
    }
    
    var ballAnimationDuration: Double {
        return animationDuration
    }
    
    var changeTintColorAnimationDuration: Double {
        return animationDuration
    }
    
    var scaleBallDelayTime: Double {
        return animationDuration * 0.6
    }
    
    var backgroundColor = UIColor.clear
    var ballColor = UIColor.clear
    var tintColor = UIColor.systemBlue
    var unselectedItemTintColor = UIColor.systemGray
    var barTintColor = UIColor.clear
    
}
