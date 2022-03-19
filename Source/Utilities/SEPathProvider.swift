//
//  SEPathProvider.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 11/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class SEPathProvider {
    
    static func getHolePath(for bounds: CGRect, startOffset: CGFloat, coverOffset: CGFloat, itemWidth: CGFloat, sectionHeight: CGFloat, heightScalingFactor: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // begin hole
        path.addQuadCurve(to: CGPoint(x: startOffset + itemWidth * 0.2, y: sectionHeight * 0.2), controlPoint: CGPoint(x: startOffset + itemWidth * 0.2, y: 0))
        
        let xInset = itemWidth * 0.6 * 0.05
        let yInset = itemWidth * 0.6 * 2.0 / 3.0
        
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.8, y: heightScalingFactor * (sectionHeight * 0.2)),
                      controlPoint1: CGPoint(x: startOffset + xInset + (itemWidth * 0.2), y: yInset + (heightScalingFactor * sectionHeight * 0.2)),
                      controlPoint2: CGPoint(x: startOffset + (itemWidth * 0.8) - xInset, y: yInset + (heightScalingFactor * sectionHeight * 0.2)))
        path.addQuadCurve(to: CGPoint(x: startOffset + itemWidth, y: 0), controlPoint: CGPoint(x: startOffset + itemWidth * 0.8, y: 0))
        // end hole
        
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: sectionHeight))
        path.close()

        
        return path.cgPath
    }
    
    static func getInvertedPlateauPath(for bounds: CGRect, startOffset: CGFloat, coverOffset: CGFloat, itemWidth: CGFloat, sectionHeight: CGFloat, heightScalingFactor: CGFloat) -> CGPath {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        // 0
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // begin plateau
        // 1
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.075, y: heightScalingFactor * 1),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.0064, y: heightScalingFactor * 0.385),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.0569, y: heightScalingFactor * 0.42))
        // 2
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.11705, y: heightScalingFactor * 4.145),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.09335, y: heightScalingFactor * 1.59),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.11125, y: heightScalingFactor * 3.375))
        // 3
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.15, y: heightScalingFactor * 10),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.13325, y: heightScalingFactor * 6.305),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.15, y: heightScalingFactor * 10))
        // 4
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.235, y: heightScalingFactor * 29),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.15, y: heightScalingFactor * 10),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.1909, y: heightScalingFactor * 21.28))
        // 5
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.265, y: heightScalingFactor * 34),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.2404, y: heightScalingFactor * 29.95),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.25215, y: heightScalingFactor * 32.125))
        // 6
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.305, y: heightScalingFactor * 38.5),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.27525, y: heightScalingFactor * 35.49),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.2963, y: heightScalingFactor * 37.715))
        // 7
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.36, y: heightScalingFactor * 42),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.32565, y: heightScalingFactor * 40.365),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.3454, y: heightScalingFactor * 41.435))
        // 8
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.5, y: heightScalingFactor * 44.5),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.4025, y: heightScalingFactor * 43.65),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.451, y: heightScalingFactor * 44.5))
        // 9
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.64, y: heightScalingFactor * 42),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.549, y: heightScalingFactor * 44.5),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.5975, y: heightScalingFactor * 43.65))
        // 10
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.695, y: heightScalingFactor * 38.5),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.6546, y: heightScalingFactor * 41.435),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.67435, y: heightScalingFactor * 40.365))
        // 11
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.735, y: heightScalingFactor * 34),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.7037, y: heightScalingFactor * 37.715),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.72475, y: heightScalingFactor * 35.49))
        // 12
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.765, y: heightScalingFactor * 29),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.74785, y: heightScalingFactor * 32.125),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.7596, y: heightScalingFactor * 29.95))
        // 13
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.85, y: heightScalingFactor * 10),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.8091, y: heightScalingFactor * 21.28),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.85, y: heightScalingFactor * 10))
        // 14
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.88295, y: heightScalingFactor * 4.145),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.85, y: heightScalingFactor * 10),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.86675, y: heightScalingFactor * 6.305))
        // 15
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.925, y: heightScalingFactor * 1),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.88875, y: heightScalingFactor * 3.375),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.90665, y: heightScalingFactor * 1.59))
        // 16
        path.addCurve(to: CGPoint(x: startOffset + itemWidth, y: heightScalingFactor * 0),
                      controlPoint1: CGPoint(x: startOffset + itemWidth * 0.9431, y: heightScalingFactor * 0.42),
                      controlPoint2: CGPoint(x: startOffset + itemWidth * 0.9936, y: heightScalingFactor * 0.385))
        // end plateau
        
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: sectionHeight))
        path.close()
        
        return path.cgPath

    }
    
    static func getRectangularMorphForPlateau(for bounds: CGRect, startOffset: CGFloat, coverOffset: CGFloat, itemWidth: CGFloat, sectionHeight: CGFloat) -> CGPath {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        // 0
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // straighten plateau path
        // 1
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.075, y: 0))
        // 2
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.11705, y: 0))
        // 3
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.15, y: 0))
        // 4
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.235, y: 0))
        // 5
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.265, y: 0))
        // 6
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.305, y: 0))
        // 7
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.36, y: 0))
        // 8
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.5, y: 0))
        // 9
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.64, y: 0))
        // 10
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.695, y: 0))
        // 11
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.735, y: 0))
        // 12
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.765, y: 0))
        // 13
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.85, y: 0))
        // 14
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.88295, y: 0))
        // 15
        path.addLine(to: CGPoint(x: startOffset + itemWidth * 0.925, y: 0))
        // 16
        path.addLine(to: CGPoint(x: startOffset + itemWidth, y: 0))
        // end straighten path
        
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: sectionHeight))
        path.close()
        return path.cgPath
    }
    
    static func getBumpMorph(for bounds: CGRect, startOffset: CGFloat, coverOffset: CGFloat, itemWidth: CGFloat, sectionHeight: CGFloat, heightScalingFactor: CGFloat)  -> CGPath {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        // 0
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // begin bump
        // 1
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 6.25, y: heightScalingFactor * -0.87), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 1.93, y: heightScalingFactor * 0.04), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 4.21, y: heightScalingFactor * -0.29))
        // 2
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 12.5, y: heightScalingFactor * -3.3), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 8.31, y: heightScalingFactor * -1.46), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 10.3, y: heightScalingFactor * -2.31))
        // 3
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 18.75, y: heightScalingFactor * -6.17), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 14.43, y: heightScalingFactor * -4.17), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 16.65, y: heightScalingFactor * -5.15))
        // 4
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 25, y: heightScalingFactor * -9.14), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 20.78, y: heightScalingFactor * -7.15), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 22.8, y: heightScalingFactor * -8.16))
        // 5
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 31.25, y: heightScalingFactor * -11.62), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 26.97, y: heightScalingFactor * -10.01), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 29.1, y: heightScalingFactor * -10.86))
        // 6
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 37.5, y: heightScalingFactor * -13.51), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 33.29, y: heightScalingFactor * -12.34), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 35.29, y: heightScalingFactor * -12.98))
        // 7
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 43.75, y: heightScalingFactor * -14.63), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 39.48, y: heightScalingFactor * -13.99), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 41.58, y: heightScalingFactor * -14.37))
        // 8
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 50, y: heightScalingFactor * -15), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 45.77, y: heightScalingFactor * -14.87), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 47.84, y: heightScalingFactor * -15))
        // 9
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 56.25, y: heightScalingFactor * -14.63), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 52.16, y: heightScalingFactor * -15), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 54.23, y: heightScalingFactor * -14.87))
        // 10
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 62.5, y: heightScalingFactor * -13.51), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 58.42, y: heightScalingFactor * -14.37), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 60.52, y: heightScalingFactor * -13.99))
        // 11
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 68.75, y: heightScalingFactor * -11.62), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 64.71, y: heightScalingFactor * -12.98), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 66.71, y: heightScalingFactor * -12.34))
        // 12
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 75, y: heightScalingFactor * -9.14), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 70.9, y: heightScalingFactor * -10.86), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 73.03, y: heightScalingFactor * -10.01))
        // 13
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 81.25, y: heightScalingFactor * -6.17), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 77.2, y: heightScalingFactor * -8.16), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 79.22, y: heightScalingFactor * -7.15))
        // 14
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 87.5, y: heightScalingFactor * -3.3), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 83.35, y: heightScalingFactor * -5.15), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 85.57, y: heightScalingFactor * -4.17))
        // 15
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 93.75, y: heightScalingFactor * -0.87), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 89.7, y: heightScalingFactor * -2.31), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 91.69, y: heightScalingFactor * -1.46))
        // 16
        path.addCurve(to: CGPoint(x: startOffset + itemWidth * 0.01 * 100, y: heightScalingFactor * -0), controlPoint1: CGPoint(x: startOffset + itemWidth * 0.01 * 95.79, y: heightScalingFactor * -0.29), controlPoint2: CGPoint(x: startOffset + itemWidth * 0.01 * 98.07, y: heightScalingFactor * 0.04))
        // end bump
        
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: bounds.width + coverOffset, y: sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: sectionHeight))
        path.close()
        
        return path.cgPath
    }
    
    static func createRotateBallPaths(forSelectedIndex selectedTabIndex: Int, previousTabIndex: Int, sectionWidth: CGFloat, ballLayerYPosition: CGFloat) -> [String: CGPath] {
        let hidePath = UIBezierPath()
        let showPath = UIBezierPath()
        
        let moveFromPointForHidePath = CGPoint(x: sectionWidth * 0.5 + (CGFloat(previousTabIndex) * sectionWidth), y: ballLayerYPosition)
        let moveToPointForShowPath = CGPoint(x: sectionWidth * 0.5 + (CGFloat(selectedTabIndex) * sectionWidth), y: ballLayerYPosition)
        
        hidePath.move(to: moveFromPointForHidePath)
        
        
        
        if previousTabIndex > selectedTabIndex {
            // hide logic
            hidePath.addCurve(to: CGPoint(x: moveFromPointForHidePath.x + 25, y: moveFromPointForHidePath.y + 50.25), controlPoint1: CGPoint(x: moveFromPointForHidePath.x + 12.5, y: moveFromPointForHidePath.y + 7.25), controlPoint2: CGPoint(x: moveFromPointForHidePath.x + 20.75, y: moveFromPointForHidePath.y + 25.25))
            // show logic
            showPath.move(to: CGPoint(x: moveToPointForShowPath.x - 25, y: moveToPointForShowPath.y + 50))
            showPath.addCurve(to: moveToPointForShowPath, controlPoint1: CGPoint(x: moveToPointForShowPath.x - 20.75, y: moveToPointForShowPath.y + 25.25), controlPoint2: CGPoint(x: moveToPointForShowPath.x - 12.5, y: moveToPointForShowPath.y + 7.25))


        }
        else {
            // hide logic
            hidePath.addCurve(to: CGPoint(x: moveFromPointForHidePath.x - 25, y: moveFromPointForHidePath.y + 50.25), controlPoint1: CGPoint(x: moveFromPointForHidePath.x - 12.5, y: moveFromPointForHidePath.y + 7.25), controlPoint2: CGPoint(x: moveFromPointForHidePath.x - 20.75, y: moveFromPointForHidePath.y + 25.25))
            // show logic
            showPath.move(to: CGPoint(x: moveToPointForShowPath.x + 25, y: moveToPointForShowPath.y + 50))
            showPath.addCurve(to: moveToPointForShowPath, controlPoint1: CGPoint(x: moveToPointForShowPath.x + 20.75, y: moveToPointForShowPath.y + 25.25), controlPoint2: CGPoint(x: moveToPointForShowPath.x + 12.5, y: moveToPointForShowPath.y + 7.25))
        }
        
        return ["hide": hidePath.cgPath, "show": showPath.cgPath]
    }
    
}
