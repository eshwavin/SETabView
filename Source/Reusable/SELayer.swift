//
//  SELayer.swift
//  SETabView
//
//  Created by Srivinayak Chaitanya Eshwa on 12/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class SELayer: CALayer {

    func scale() {
        
        let animation = SELayerAnimationProvider.getScaleAnimation(runningFor: SETabSettings.current.ballAnimationDuration, fromValue: 0.5, toValue: 1.0, timingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.default), fillMode: .both, beginTime: CACurrentMediaTime() + SETabSettings.current.scaleBallDelayTime, isRemovedOnCompletion: true)
        
        add(animation, forKey: nil)
        
    }
    
    func moveUp(to toValue: CGFloat) {
        let moveUpAnimation = SELayerAnimationProvider.getTranslateYAnimation(runningFor: SETabSettings.current.changeTintColorAnimationDuration, fromValue: nil, toValue: toValue, timingFunction: SETimingFunction.seEaseInOut, fillMode: .both, isRemovedOnCompletion: false)
        
        
        add(moveUpAnimation, forKey: nil)
        
    }
    
    func highlight(inDuration duration: Double = SETabSettings.current.changeTintColorAnimationDuration) {
        let highlightAnimation = SELayerAnimationProvider.getBackgroundChangeAnimation(runningFor: duration, toValue: SETabSettings.current.tintColor.cgColor, timingFunction: SETimingFunction.seEaseInOut, fillMode: .both, isRemovedOnCompletion: false)
        
        add(highlightAnimation, forKey: nil)
    }
    
    func moveDown(to toValue: CGFloat) {
        let downMovementAnimation = SELayerAnimationProvider.getTranslateYAnimation(runningFor: SETabSettings.current.changeTintColorAnimationDuration, toValue: toValue, timingFunction: SETimingFunction.seEaseInOut, fillMode: .both, isRemovedOnCompletion: false)
        
        add(downMovementAnimation, forKey: nil)

    }
    
    func removeHighlight(inDuration duration: Double = SETabSettings.current.changeTintColorAnimationDuration) {
        let removeHighlightAnimation = SELayerAnimationProvider.getBackgroundChangeAnimation(runningFor: duration, toValue: SETabSettings.current.unselectedItemTintColor.cgColor, timingFunction: SETimingFunction.seEaseInOut, fillMode: .both, isRemovedOnCompletion: false)
        
        add(removeHighlightAnimation, forKey: nil)
        
    }
    
    func translateLinear(to toValue: CGFloat) {
        let linearAnimation = SELayerAnimationProvider.getTranslateXAnimation(runningFor: SETabSettings.current.ballAnimationDuration, toValue: toValue, timingFunction: SETimingFunction.seEaseInOut, fillMode: .both, isRemovedOnCompletion: false)
        
        
        add(linearAnimation, forKey: nil)

    }
    
    func translateTriangular(with values: [NSValue]) {
        let translateTriangularAnimation = SELayerAnimationProvider.getKeyframePositionAnimation(runningFor: SETabSettings.current.ballAnimationDuration, values: values, keyTimes: [0.0, 0.5, 1.0], timingFunctions: [SETimingFunction.seEaseIn, SETimingFunction.seEaseOut], fillMode: .forwards)
        
        
        add(translateTriangularAnimation, forKey: nil)
    }
    
    func moveInPath(_ path: CGPath?, fillMode: CAMediaTimingFillMode = .removed) {
        let rotateAnimation = SELayerAnimationProvider.getKeyframePositionAnimation(runningFor: SETabSettings.current.ballAnimationDuration, path: path, timingFunction: SETimingFunction.seEaseInOut, fillMode: fillMode, isRemovedOnCompletion: false)
        
        add(rotateAnimation, forKey: nil)
    }
    
}

