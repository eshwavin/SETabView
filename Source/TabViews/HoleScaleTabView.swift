//
//  HoleScaleTabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 10/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class HoleScaleTabView: AnimatedTabView {
    
}

// MARK: Setup

extension HoleScaleTabView {
    
    override func setupTabLayers() {
        super.setupTabLayers()
        
        let ballLayerX = sectionWidth * 0.5 - (ballSize * 0.5) + (CGFloat(selectedTabIndex) * sectionWidth)
        let ballLayerY = itemHeight * 0.25 - (ballSize * 0.5)
        ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: ballSize, height: ballSize)
        ballLayer.cornerRadius = ballSize / 2.0
        
        // setup shape layer
        tabShapeLayer.frame = bounds
        tabShapeLayer.path = createHolePath()
        
        // setup images
        tabImageLayers.enumerated().forEach { (offset, imageLayer) in
            
            let y = offset == Int(selectedTabIndex) ? 0 : (bounds.height / 2) - (iconSize / 2)
            let x = (CGFloat(offset) * sectionWidth) + (sectionWidth / 2.0) - (iconSize / 2.0)
            imageLayer.frame = CGRect(x: x, y: y, width: iconSize, height: iconSize)
            imageLayer.mask?.frame = imageLayer.bounds
            imageLayer.backgroundColor = offset == Int(selectedTabIndex) ? SETabSettings.current.tintColor.cgColor : SETabSettings.current.unselectedItemTintColor.cgColor
            
        }
    }
    
}

// MARK: Paths

extension HoleScaleTabView {
    
    private func createHolePath() -> CGPath {
        
        let startOffset = ((sectionWidth - itemWidth) / 2)
        let coverOffset = CGFloat(numberOfTabs - 1) * sectionWidth
        
        return SEPathProvider.getHolePath(for: bounds, startOffset: startOffset, coverOffset: coverOffset, itemWidth: itemWidth, sectionHeight: sectionHeight, heightScalingFactor: heightScalingFactor)
        
    }

}

// MARK: Animations

extension HoleScaleTabView {
    
    override func performAnimations() {
        super.performAnimations()
        scaleBall()
    }
    
    private func scaleBall() {
        
        // move ball to new location
        let ballLayerX = sectionWidth * 0.5 - (ballSize * 0.5) + (CGFloat(selectedTabIndex) * sectionWidth)
        let ballLayerY = itemHeight * 0.25 - (ballSize * 0.5)
        ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: ballSize, height: ballSize)
        
        // animate ball
        ballLayer.scale()
        
    }
    
}
