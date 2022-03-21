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
    
    private var animationDuration: Double = 1.5
    
    var switchTabAnimationDuration: Double {
        return animationDuration * 0.3
    }
    
    var ballAnimationDuration: Double {
        return animationDuration * 0.3
    }
    
    var changeTintColorAnimationDuration: Double {
        return animationDuration * 0.3
    }
    
    var scaleBallDelayTime: Double {
        return animationDuration * 0.2
    }
    
    var backgroundColor = UIColor.clear
    var ballColor = UIColor.clear
    var tintColor = UIColor.systemBlue
    var unselectedItemTintColor = UIColor.systemGray
    var barTintColor = UIColor.clear
    
}
