//
//  InvertedPlateauTabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 11/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class InvertedPlateauTabView: AnimatedTabView {
    
}

// MARK: Setup

extension InvertedPlateauTabView {
    
    override func setupTabLayers() {
        super.setupTabLayers()
        // setup ball layer
        let ballLayerX = sectionWidth * 0.5 - (ballSize * 0.5) + (CGFloat(selectedTabIndex) * sectionWidth)
        let ballLayerY = itemHeight * 0.25 - (ballSize * 0.5)
        ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: ballSize, height: ballSize)
        ballLayer.cornerRadius = ballSize / 2.0
        
        // setup shape layer
        tabShapeLayer.frame = bounds
        tabShapeLayer.path = createInvertedPlateauPath(withOffset: true)
        
        setupTabImagePositions()
    }
    
}

// MARK: Paths

extension InvertedPlateauTabView {
    
    private func createInvertedPlateauPath(withOffset: Bool) -> CGPath {
        
        var startOffset: CGFloat{
            if withOffset {
                return (sectionWidth - itemWidth) / 2
            }
            else {
                return 0
            }
        }
        
        let coverOffset = CGFloat(numberOfTabs - 1) * sectionWidth
        
        return SEPathProvider.getInvertedPlateauPath(for: bounds, startOffset: startOffset, coverOffset: coverOffset, itemWidth: itemWidth, sectionHeight: sectionHeight, heightScalingFactor: heightScalingFactor)
    }

    
}

// MARK: Animations

extension InvertedPlateauTabView {
    
    override func performAnimations() {
        super.performAnimations()
        translateBallTriangular()
    }
    
    private func translateBallTriangular() {
        
        let ballLayerX = sectionWidth * 0.5 - (ballSize * 0.5) + (CGFloat(selectedTabIndex) * sectionWidth)
        let ballLayerY = itemHeight * 0.25 - (ballSize * 0.5)
        
        let previousPosition = ballLayer.position
        let newPosition = CGPoint(x: ballLayerX + ballSize / 2, y: ballLayerY + ballSize / 2)
        let midPosition = CGPoint(x: (newPosition.x + previousPosition.x) * 0.5 , y: bounds.height * 1.5)
        
        ballLayer.position = newPosition
        
        ballLayer.translateTriangular(with: [previousPosition, midPosition, newPosition].map{NSValue(cgPoint: $0)})
        
    }

}
