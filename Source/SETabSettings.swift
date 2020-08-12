//
//  SETabSettings.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 11/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

class SETabSettings {
    
    public static var current = SETabSettings()
    
    private init() {}
    
    public var animationDuration: Double = 1.5
    
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
    
    public var tabColor = UIColor.black
    public var ballColor = UIColor.black
    public var selectedTabTintColor = UIColor.white
    public var deselectedTabTintColor = UIColor.gray
    
}
