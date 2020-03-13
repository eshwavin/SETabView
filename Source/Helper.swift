//
//  Protocols.swift
//  VCTabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 17/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

public protocol SETabViewDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

public protocol SETabItem {
    var tabImage: UIImage? {get}
}

public class SETabSettings {
    
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
    
    public var tabColor = UIColor.white
    public var ballColor = UIColor.white
    public var selectedTabTintColor = UIColor.black
    public var unselectedTabTintColor = UIColor.gray
    
}

public enum AnimationTypes {
    case holeBall1
    case holeBall2
    case holeBall3
}

public let seEaseIn = CAMediaTimingFunction(controlPoints: 0.6, 0, 1, 1)
public let seEaseOut = CAMediaTimingFunction(controlPoints: 0, 0, 0.4, 1)
public let seEaseInOut = CAMediaTimingFunction(controlPoints: 0.6, 0, 0.4, 1)
