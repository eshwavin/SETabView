//
//  SEShapeLayer.swift
//  SETabView
//
//  Created by Srivinayak Chaitanya Eshwa on 12/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class SEShapeLayer: CAShapeLayer {

    func translate(to toValue: CGFloat) {
        let translateAnimation = SELayerAnimationProvider.getTranslateXAnimation(runningFor: SETabSettings.current.switchTabAnimationDuration, fromValue: nil, toValue: toValue, timingFunction: SETimingFunction.seEaseInOut, fillMode: CAMediaTimingFillMode.both, beginTime: nil, isRemovedOnCompletion: false)
        
        add(translateAnimation, forKey: nil)
    }
    
    func morph(using paths: [CGPath]) {
        let morphAnimation = SELayerAnimationProvider.getKeyframePathAnimation(runningFor: SETabSettings.current.switchTabAnimationDuration,
        values: paths,
        keyTimes: [0.0, 0.25, 0.4, 0.65, 0.85, 1.0],
        timingFunctions: [SETimingFunction.seEaseIn, SETimingFunction.seEaseOut, CAMediaTimingFunction(name: .linear), SETimingFunction.seEaseIn, SETimingFunction.seEaseOut],
        fillMode: .both, isRemovedOnCompletion: true)
        
        add(morphAnimation, forKey: nil)
    }
    
}
