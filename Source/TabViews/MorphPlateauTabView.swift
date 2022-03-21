//
//  MorphPlateauTabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 11/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class MorphPlateauTabView: AnimatedTabView {
    
    // MARK: Properties: Layer
    private var ballLayerReplica = SELayer()
    
    // MARK: Properties: Path
    private var invertedPlateauPath: CGPath?
    private var rectangularMorphPath: CGPath?
    private var bumpPath: CGPath?
    
    override func layoutSubviewsAfterSetup() {
        super.layoutSubviewsAfterSetup()
        rotateBall()
    }
}

// MARK: Colors

extension MorphPlateauTabView {
    override func setBallColor() {
        super.setBallColor()
        ballLayerReplica.backgroundColor = SETabSettings.current.ballColor.cgColor
    }
}

// MARK: Setup

extension MorphPlateauTabView {
    
    override func setupView() {
        super.setupView()
        layer.insertSublayer(ballLayerReplica, below: ballLayer)
    }
    
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
        
        // setup replica ball layer
        ballLayerReplica.frame = CGRect(x: 200, y: 200, width: ballLayer.bounds.width, height: ballLayer.bounds.height)
        ballLayerReplica.cornerRadius = ballSize / 2.0
        
        self.invertedPlateauPath = self.createInvertedPlateauPath(withOffset: true)
        self.bumpPath = self.createBumpMorph()
        self.rectangularMorphPath = self.createRectangularMorphForPlateau()
        
        setupTabImagePositions()
    }

}

// MARK: Paths

extension MorphPlateauTabView {
    
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
    
    private func createRectangularMorphForPlateau() -> CGPath{
        
        let startOffset: CGFloat = (sectionWidth - itemWidth) / 2
        let coverOffset = CGFloat(numberOfTabs - 1) * sectionWidth
        
        return SEPathProvider.getRectangularMorphForPlateau(for: bounds, startOffset: startOffset, coverOffset: coverOffset, itemWidth: itemWidth, sectionHeight: sectionHeight)
        
    }
    
    private func createBumpMorph() -> CGPath {
        
        let startOffset: CGFloat = (sectionWidth - itemWidth) / 2
        let coverOffset = CGFloat(numberOfTabs - 1) * sectionWidth
        
        return SEPathProvider.getBumpMorph(for: bounds, startOffset: startOffset, coverOffset: coverOffset, itemWidth: itemWidth, sectionHeight: sectionHeight, heightScalingFactor: heightScalingFactor)
        
    }
    
    private func createRotateBallPaths() -> [String: CGPath] {
        
        return SEPathProvider.createRotateBallPaths(forSelectedIndex: selectedTabIndex, previousTabIndex: previousTabIndex, sectionWidth: sectionWidth, ballLayerYPosition: ballLayer.position.y)
        
    }
    
}

// MARK: Animations

extension MorphPlateauTabView {
    
    override func performAnimations() {
        super.performAnimations()
        if (abs(previousTabIndex - selectedTabIndex) == 1) {
            rotateBall()
        }
        else {
            morphShapeLayer()
            translateBallLinear()
        }
    }
    
    private func morphShapeLayer() {
        
        tabShapeLayer.morph(using: [invertedPlateauPath!, rectangularMorphPath!, bumpPath!, bumpPath!, rectangularMorphPath!, invertedPlateauPath!])
        
    }
    
    private func translateBallLinear() {
        
        let ballLayerX = sectionWidth * 0.5 - (ballSize * 0.5) + (CGFloat(selectedTabIndex) * sectionWidth)
        let toValue = ballLayerX + ballSize / 2
        
        ballLayer.translateLinear(to: toValue)
    }
    
    private func rotateBall() {
        
        let rotatePaths = createRotateBallPaths()
        
        ballLayerReplica.moveInPath(rotatePaths["hide"])
        ballLayer.moveInPath(rotatePaths["show"], fillMode: .both)
        
    }
    
}
