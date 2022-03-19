//
//  SELayerAnimationProvider.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 10/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class SELayerAnimationProvider {
    
    // MARK: Animation Functions
    
    static func getTranslateXAnimation(runningFor duration: CFTimeInterval, fromValue: Any? = nil, toValue: Any, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode, beginTime: CFTimeInterval? = nil, isRemovedOnCompletion: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.x")
        
        setupBasicAnimation(animation, duration: duration, fromValue: fromValue, toValue: toValue, timingFunction: timingFunction, fillMode: fillMode, beginTime: beginTime, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }
    
    static func getScaleAnimation(runningFor duration: CFTimeInterval, fromValue: Any? = nil, toValue: Any, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode, beginTime: CFTimeInterval? = nil, isRemovedOnCompletion: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        setupBasicAnimation(animation, duration: duration, fromValue: fromValue, toValue: toValue, timingFunction: timingFunction, fillMode: fillMode, beginTime: beginTime, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }
    
    static func getTranslateYAnimation(runningFor duration: CFTimeInterval, fromValue: Any? = nil, toValue: Any, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode, beginTime: CFTimeInterval? = nil, isRemovedOnCompletion: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.y")
        
        setupBasicAnimation(animation, duration: duration, fromValue: fromValue, toValue: toValue, timingFunction: timingFunction, fillMode: fillMode, beginTime: beginTime, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }
    
    static func getBackgroundChangeAnimation(runningFor duration: CFTimeInterval, fromValue: Any? = nil, toValue: Any, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode, beginTime: CFTimeInterval? = nil, isRemovedOnCompletion: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        
        setupBasicAnimation(animation, duration: duration, fromValue: fromValue, toValue: toValue, timingFunction: timingFunction, fillMode: fillMode, beginTime: beginTime, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }

    static func getKeyframePositionAnimation(runningFor duration: CFTimeInterval, values: [NSValue], keyTimes: [NSNumber]?, timingFunctions: [CAMediaTimingFunction], fillMode: CAMediaTimingFillMode, isRemovedOnCompletion: Bool = true) -> CAKeyframeAnimation {
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        setupKeyframeAnimation(animation, duration: duration, values: values, keyTimes: keyTimes, timingFunctions: timingFunctions, fillMode: fillMode, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }
    
    static func getKeyframePositionAnimation(runningFor duration: CFTimeInterval, path: CGPath?, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode = .removed, isRemovedOnCompletion: Bool = true) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        setupKeyframeAnimation(animation, duration: duration, path: path, timingFunction: timingFunction, fillMode: fillMode, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }
    
    static func getKeyframePathAnimation(runningFor duration: CFTimeInterval, values: [CGPath], keyTimes: [NSNumber]?, timingFunctions: [CAMediaTimingFunction], fillMode: CAMediaTimingFillMode, isRemovedOnCompletion: Bool = true) -> CAKeyframeAnimation {
        
        let animation = CAKeyframeAnimation(keyPath: "path")
        
        setupKeyframeAnimation(animation, duration: duration, values: values, keyTimes: keyTimes, timingFunctions: timingFunctions, fillMode: fillMode, isRemovedOnCompletion: isRemovedOnCompletion)
        
        return animation
    }
    
    // MARK: Utility Functions
    
    private static func setupBasicAnimation(_ animation: CABasicAnimation, duration: CFTimeInterval, fromValue: Any?, toValue: Any, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode, beginTime: CFTimeInterval?, isRemovedOnCompletion: Bool) {
        
        if let fromValue = fromValue {
            animation.fromValue = fromValue
        }
        animation.toValue = toValue
        animation.duration = duration
        animation.fillMode = fillMode
        
        if let beginTime = beginTime {
            animation.beginTime = beginTime
        }
        animation.isRemovedOnCompletion = isRemovedOnCompletion
    }
    
    private static func setupKeyframeAnimation(_ animation: CAKeyframeAnimation, duration: CFTimeInterval, values: [Any], keyTimes: [NSNumber]?, timingFunctions: [CAMediaTimingFunction], fillMode: CAMediaTimingFillMode, isRemovedOnCompletion: Bool = true) {
        
        animation.duration = duration
        animation.values = values
        
        if let keyTimes = keyTimes {
            animation.keyTimes = keyTimes
        }
        
        animation.timingFunctions = timingFunctions
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        
    }
    
    private static func setupKeyframeAnimation(_ animation: CAKeyframeAnimation, duration: CFTimeInterval, path: CGPath?, timingFunction: CAMediaTimingFunction, fillMode: CAMediaTimingFillMode, isRemovedOnCompletion: Bool) {
        animation.duration = duration
        animation.path = path
        animation.timingFunction = timingFunction
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = isRemovedOnCompletion
    }
        
}
