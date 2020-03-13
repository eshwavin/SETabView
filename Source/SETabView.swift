//
//  SETabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 15/02/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

public class SETabView: UIView {
    
    // MARK: Properties: Tab
    /// Specifies the current tab index selected
    public var selectedTabIndex: Int = 0 {
        didSet {
            self.moveToSelectedTab()
        }
    }
    private var previousTabIndex: Int = -1
    
    /// Images for the tabBar icons
    public var tabImages = [UIImage]() {
        willSet {
            if !tabImages.isEmpty {
                fatalError("Tab images cannot be set multiple times")
            }
        }
        didSet {
            self.addTabImages()
        }
    }
    
    /// Specifies the animation type
    public var animationType: AnimationTypes = .holeBall3
    
    private var numberOfTabs: Int {
        return self.tabImages.count
    }
    
    /// the object that acts as the delegate of the SETabView
    public weak var delegate: SETabViewDelegate?
    public static var settings: SETabSettings = SETabSettings()

    // MARK: Properties: Layer
    private let tabShapeLayer = CAShapeLayer()
    private let ballLayer = CALayer()
    private var tabImageLayers = [CALayer]()
    
    private var ballLayerReplica: CALayer? // only for holaAnimation3
    
    // MARK: Properties: Size
    
    private var sectionWidth: CGFloat {
        self.bounds.width / CGFloat(self.numberOfTabs)
    }
    
    private var sectionHeight: CGFloat {
        self.bounds.height
    }
    
    private var itemWidth: CGFloat {
        self.sectionWidth > 100 ? 100: self.sectionWidth
    }
    
    private var ballSize: CGFloat {
        self.itemWidth / 2.0
    }
    
    private var iconSize: CGFloat {
        self.ballSize / 1.8
    }
    
    private var itemHeight: CGFloat {
        let height = self.bounds.height
        return height > self.ballSize ? self.ballSize : height
    }
    
    private var heightScalingFactor: CGFloat {
        self.itemWidth / 100
    }
    
    // MARK: Properties: Path
    private var invertedPlateauPath: CGPath?
    private var rectangularMorphPath: CGPath?
    private var bumpPath: CGPath?
    
    
    // MARK: Properties: Misc
    private var setup = false
    
    // MARK: Functions: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
        
    // MARK: Functions: Lifecycle
        
    override open func layoutSubviews() {
        super.layoutSubviews()
        if !self.setup {
            self.setupTabBarFrames()
            self.setup = true
        }
        
    }
    
    // MARK: Functions: Setup Components
    
    // sets up different layers of the tabBar
    private func setupView() {
     
        self.ballLayer.backgroundColor = SETabView.settings.ballColor.cgColor
        self.layer.addSublayer(self.ballLayer)
        
        self.tabShapeLayer.fillColor = SETabView.settings.tabColor.cgColor
        self.tabShapeLayer.lineWidth = 0.5
        self.tabShapeLayer.position = CGPoint(x: 0, y: 0) // 10, 10 originally
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(self.tabShapeLayer)
        
        self.previousTabIndex = 0

    }
    
    // adds the images as layers to the tabBar
    private func addTabImages() {
        self.tabImages.map { (image) -> CALayer in
            let maskLayer = CALayer()
            maskLayer.contents = image.cgImage
            maskLayer.contentsGravity = .resizeAspect
            let imageLayer = CALayer()
            imageLayer.mask = maskLayer
            self.tabImageLayers.append(imageLayer)
            return imageLayer
        }.forEach(self.layer.addSublayer(_:))
    }
    
    // MARK: Functions: Setup Look
    
    // set/updates frames of the various layers
    private func setupTabBarFrames() {
        
        switch self.animationType {
            case .holeBall1:
                self.setupFramesForHoleBall1()
            case .holeBall2:
                self.setupFramesForHoleBall2()
            case .holeBall3:
                self.setupFramesForHoleBall3()
        }
                
    }
    
    private func setupFramesForHoleBall1() {
        // setup ball layer
        let ballLayerX = self.sectionWidth * 0.5 - (self.ballSize * 0.5) + (CGFloat(self.selectedTabIndex) * self.sectionWidth)
        let ballLayerY = self.itemHeight * 0.25 - (self.ballSize * 0.5)
        self.ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: self.ballSize, height: self.ballSize)
        self.ballLayer.cornerRadius = self.ballSize / 2.0
        
        // setup shape layer
        self.tabShapeLayer.frame = self.bounds
        self.tabShapeLayer.path = self.createHolePath()
        
        // setup images
        self.tabImageLayers.enumerated().forEach { (offset, imageLayer) in
            
            let y = offset == Int(self.selectedTabIndex) ? 0 : (bounds.height / 2) - (self.iconSize / 2)
            let x = (CGFloat(offset) * self.sectionWidth) + (self.sectionWidth / 2.0) - (self.iconSize / 2.0)
            imageLayer.frame = CGRect(x: x, y: y, width: self.iconSize, height: self.iconSize)
            imageLayer.mask?.frame = imageLayer.bounds
            imageLayer.backgroundColor = offset == Int(self.selectedTabIndex) ? SETabView.settings.selectedTabTintColor.cgColor : SETabView.settings.unselectedTabTintColor.cgColor
            
        }
    }
    
    private func setupFramesForHoleBall2() {
        
        // setup ball layer
        let ballLayerX = self.sectionWidth * 0.5 - (self.ballSize * 0.5) + (CGFloat(self.selectedTabIndex) * self.sectionWidth)
        let ballLayerY = self.itemHeight * 0.25 - (self.ballSize * 0.5)
        self.ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: self.ballSize, height: self.ballSize)
        self.ballLayer.cornerRadius = self.ballSize / 2.0
        
        // setup shape layer
        self.tabShapeLayer.frame = self.bounds
        self.tabShapeLayer.path = self.createInvertedPlateauPath(withOffset: true)
        
        // setup images
        self.tabImageLayers.enumerated().forEach { (offset, imageLayer) in
            
            let y = offset == Int(self.selectedTabIndex) ? 0 : (bounds.height / 2) - (self.iconSize / 2)
            let x = (CGFloat(offset) * self.sectionWidth) + (self.sectionWidth / 2.0) - (self.iconSize / 2.0)
            imageLayer.frame = CGRect(x: x, y: y, width: self.iconSize, height: self.iconSize)
            imageLayer.mask?.frame = imageLayer.bounds
            imageLayer.backgroundColor = offset == Int(self.selectedTabIndex) ? SETabView.settings.selectedTabTintColor.cgColor : SETabView.settings.unselectedTabTintColor.cgColor
            
        }
        
    }
    
    private func setupFramesForHoleBall3() {
        self.setupFramesForHoleBall2()
        // setup replica ball layer
        self.ballLayerReplica = CALayer()
        self.ballLayerReplica?.frame = CGRect(x: 200, y: 200, width: self.ballLayer.bounds.width, height: self.ballLayer.bounds.height)
        self.ballLayerReplica?.cornerRadius = self.ballSize / 2.0
        self.ballLayerReplica?.backgroundColor = SETabView.settings.ballColor.cgColor
        self.layer.insertSublayer(self.ballLayerReplica!, below: self.ballLayer)
        
        // store paths to avoid creating multiple times
        self.invertedPlateauPath = self.createInvertedPlateauPath(withOffset: true)
        self.bumpPath = self.createBumpMorph()
        self.rectangularMorphPath = self.createRectangularMorphForPlateau()
    }
    
    // MARK: Functions: Tab Switch Control
    
    private func moveToSelectedTab() {
        
        if (self.selectedTabIndex == self.previousTabIndex) {
            self.previousTabIndex = self.selectedTabIndex
            return
        }
        
        switch self.animationType {
            
            case .holeBall1:
                self.translateShapeLayer()
                self.scaleBall()
                self.changeTintColor()
            
            case .holeBall2:
                self.translateShapeLayer()
                self.translateBallTriangular()
                self.changeTintColor()
            
        case .holeBall3:
                
                self.translateShapeLayer()
                if (abs(self.previousTabIndex - self.selectedTabIndex) == 1) {
                    self.rotateBall()
                }
                else {
                    self.morphShapeLayer()
                    self.translateBallLinear()
                }
                self.changeTintColor()
                
        }
        
        self.previousTabIndex = self.selectedTabIndex
        
    }
    
    
    // MARK: Functions: Paths
    func createHolePath() -> CGPath {
        
        let startOffset = CGFloat(self.selectedTabIndex) * self.sectionWidth + ((self.sectionWidth - self.itemWidth) / 2)
        let coverOffset = CGFloat(self.numberOfTabs - 1) * self.sectionWidth
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // begin hole
        path.addQuadCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.2, y: self.sectionHeight * 0.2), controlPoint: CGPoint(x: startOffset + self.itemWidth * 0.2, y: 0))
        
        let xInset = self.itemWidth * 0.6 * 0.05
        let yInset = self.itemWidth * 0.6 * 2.0 / 3.0
        
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.8, y: self.heightScalingFactor * (self.sectionHeight * 0.2)),
                      controlPoint1: CGPoint(x: startOffset + xInset + (self.itemWidth * 0.2), y: yInset + (self.heightScalingFactor * self.sectionHeight * 0.2)),
                      controlPoint2: CGPoint(x: startOffset + (self.itemWidth * 0.8) - xInset, y: yInset + (self.heightScalingFactor * self.sectionHeight * 0.2)))
        path.addQuadCurve(to: CGPoint(x: startOffset + self.itemWidth, y: 0), controlPoint: CGPoint(x: startOffset + self.itemWidth * 0.8, y: 0))
        // end hole
        
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: self.sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: self.sectionHeight))
        path.close()
        
        return path.cgPath
        
    }
    
    private func createInvertedPlateauPath(withOffset: Bool) -> CGPath {
        
        var startOffset: CGFloat{
            if withOffset {
                return CGFloat(self.selectedTabIndex) * self.sectionWidth + ((self.sectionWidth - self.itemWidth) / 2)
            }
            else {
                return 0
            }
        }
        
        let coverOffset = CGFloat(self.numberOfTabs - 1) * self.sectionWidth
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        // 0
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // begin plateu
        // 1
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.075, y: self.heightScalingFactor * 1),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.0064, y: self.heightScalingFactor * 0.385),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.0569, y: self.heightScalingFactor * 0.42))
        // 2
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.11705, y: self.heightScalingFactor * 4.145),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.09335, y: self.heightScalingFactor * 1.59),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.11125, y: self.heightScalingFactor * 3.375))
        // 3
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.15, y: self.heightScalingFactor * 10),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.13325, y: self.heightScalingFactor * 6.305),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.15, y: self.heightScalingFactor * 10))
        // 4
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.235, y: self.heightScalingFactor * 29),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.15, y: self.heightScalingFactor * 10),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.1909, y: self.heightScalingFactor * 21.28))
        // 5
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.265, y: self.heightScalingFactor * 34),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.2404, y: self.heightScalingFactor * 29.95),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.25215, y: self.heightScalingFactor * 32.125))
        // 6
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.305, y: self.heightScalingFactor * 38.5),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.27525, y: self.heightScalingFactor * 35.49),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.2963, y: self.heightScalingFactor * 37.715))
        // 7
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.36, y: self.heightScalingFactor * 42),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.32565, y: self.heightScalingFactor * 40.365),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.3454, y: self.heightScalingFactor * 41.435))
        // 8
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.5, y: self.heightScalingFactor * 44.5),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.4025, y: self.heightScalingFactor * 43.65),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.451, y: self.heightScalingFactor * 44.5))
        // 9
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.64, y: self.heightScalingFactor * 42),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.549, y: self.heightScalingFactor * 44.5),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.5975, y: self.heightScalingFactor * 43.65))
        // 10
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.695, y: self.heightScalingFactor * 38.5),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.6546, y: self.heightScalingFactor * 41.435),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.67435, y: self.heightScalingFactor * 40.365))
        // 11
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.735, y: self.heightScalingFactor * 34),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.7037, y: self.heightScalingFactor * 37.715),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.72475, y: self.heightScalingFactor * 35.49))
        // 12
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.765, y: self.heightScalingFactor * 29),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.74785, y: self.heightScalingFactor * 32.125),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.7596, y: self.heightScalingFactor * 29.95))
        // 13
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.85, y: self.heightScalingFactor * 10),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.8091, y: self.heightScalingFactor * 21.28),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.85, y: self.heightScalingFactor * 10))
        // 14
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.88295, y: self.heightScalingFactor * 4.145),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.85, y: self.heightScalingFactor * 10),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.86675, y: self.heightScalingFactor * 6.305))
        // 15
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.925, y: self.heightScalingFactor * 1),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.88875, y: self.heightScalingFactor * 3.375),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.90665, y: self.heightScalingFactor * 1.59))
        // 16
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth, y: self.heightScalingFactor * 0),
                      controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.9431, y: self.heightScalingFactor * 0.42),
                      controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.9936, y: self.heightScalingFactor * 0.385))
        // end plateau
        
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: self.sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: self.sectionHeight))
        path.close()
        
        return path.cgPath
        
    }
    
    
    private func createRectangularMorphForPlateau() -> CGPath{
        
        let startOffset: CGFloat = 0.0
        let coverOffset = CGFloat(self.numberOfTabs - 1) * self.sectionWidth
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        // 0
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // straighten plateau path
        // 1
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.075, y: 0))
        // 2
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.11705, y: 0))
        // 3
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.15, y: 0))
        // 4
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.235, y: 0))
        // 5
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.265, y: 0))
        // 6
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.305, y: 0))
        // 7
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.36, y: 0))
        // 8
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.5, y: 0))
        // 9
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.64, y: 0))
        // 10
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.695, y: 0))
        // 11
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.735, y: 0))
        // 12
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.765, y: 0))
        // 13
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.85, y: 0))
        // 14
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.88295, y: 0))
        // 15
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth * 0.925, y: 0))
        // 16
        path.addLine(to: CGPoint(x: startOffset + self.itemWidth, y: 0))
        // end straighten path
        
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: self.sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: self.sectionHeight))
        path.close()
        return path.cgPath
        
    }
    
    private func createBumpMorph() -> CGPath {
        
        let startOffset: CGFloat = 0.0
        let coverOffset = CGFloat(self.numberOfTabs - 1) * self.sectionWidth
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -coverOffset, y: 0))
        // 0
        path.addLine(to: CGPoint(x: startOffset, y: 0))
        
        // begin bump
        // 1
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 6.25, y: self.heightScalingFactor * -0.87), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 1.93, y: self.heightScalingFactor * 0.04), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 4.21, y: self.heightScalingFactor * -0.29))
        // 2
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 12.5, y: self.heightScalingFactor * -3.3), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 8.31, y: self.heightScalingFactor * -1.46), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 10.3, y: self.heightScalingFactor * -2.31))
        // 3
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 18.75, y: self.heightScalingFactor * -6.17), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 14.43, y: self.heightScalingFactor * -4.17), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 16.65, y: self.heightScalingFactor * -5.15))
        // 4
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 25, y: self.heightScalingFactor * -9.14), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 20.78, y: self.heightScalingFactor * -7.15), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 22.8, y: self.heightScalingFactor * -8.16))
        // 5
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 31.25, y: self.heightScalingFactor * -11.62), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 26.97, y: self.heightScalingFactor * -10.01), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 29.1, y: self.heightScalingFactor * -10.86))
        // 6
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 37.5, y: self.heightScalingFactor * -13.51), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 33.29, y: self.heightScalingFactor * -12.34), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 35.29, y: self.heightScalingFactor * -12.98))
        // 7
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 43.75, y: self.heightScalingFactor * -14.63), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 39.48, y: self.heightScalingFactor * -13.99), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 41.58, y: self.heightScalingFactor * -14.37))
        // 8
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 50, y: self.heightScalingFactor * -15), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 45.77, y: self.heightScalingFactor * -14.87), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 47.84, y: self.heightScalingFactor * -15))
        // 9
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 56.25, y: self.heightScalingFactor * -14.63), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 52.16, y: self.heightScalingFactor * -15), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 54.23, y: self.heightScalingFactor * -14.87))
        // 10
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 62.5, y: self.heightScalingFactor * -13.51), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 58.42, y: self.heightScalingFactor * -14.37), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 60.52, y: self.heightScalingFactor * -13.99))
        // 11
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 68.75, y: self.heightScalingFactor * -11.62), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 64.71, y: self.heightScalingFactor * -12.98), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 66.71, y: self.heightScalingFactor * -12.34))
        // 12
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 75, y: self.heightScalingFactor * -9.14), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 70.9, y: self.heightScalingFactor * -10.86), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 73.03, y: self.heightScalingFactor * -10.01))
        // 13
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 81.25, y: self.heightScalingFactor * -6.17), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 77.2, y: self.heightScalingFactor * -8.16), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 79.22, y: self.heightScalingFactor * -7.15))
        // 14
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 87.5, y: self.heightScalingFactor * -3.3), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 83.35, y: self.heightScalingFactor * -5.15), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 85.57, y: self.heightScalingFactor * -4.17))
        // 15
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 93.75, y: self.heightScalingFactor * -0.87), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 89.7, y: self.heightScalingFactor * -2.31), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 91.69, y: self.heightScalingFactor * -1.46))
        // 16
        path.addCurve(to: CGPoint(x: startOffset + self.itemWidth * 0.01 * 100, y: self.heightScalingFactor * -0), controlPoint1: CGPoint(x: startOffset + self.itemWidth * 0.01 * 95.79, y: self.heightScalingFactor * -0.29), controlPoint2: CGPoint(x: startOffset + self.itemWidth * 0.01 * 98.07, y: self.heightScalingFactor * 0.04))
        // end bump
        
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width + coverOffset, y: self.sectionHeight))
        path.addLine(to: CGPoint(x: -coverOffset, y: self.sectionHeight))
        path.close()
        
        return path.cgPath
    }
    
    private func createRotateBallPaths() -> [String: CGPath] {
        let hidePath = UIBezierPath()
        let showPath = UIBezierPath()
        
        let moveFromPointForHidePath = CGPoint(x: self.sectionWidth * 0.5 + (CGFloat(self.previousTabIndex) * self.sectionWidth), y: self.ballLayer.position.y)
        let moveToPointForShowPath = CGPoint(x: self.sectionWidth * 0.5 + (CGFloat(self.selectedTabIndex) * self.sectionWidth), y: self.ballLayer.position.y)
        
        hidePath.move(to: moveFromPointForHidePath)
        
        
        
        if self.previousTabIndex > self.selectedTabIndex {
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
    
    // MARK: Functions: Animations
    
    private func scaleBall() {
        
        // move ball to new location
        let ballLayerX = self.sectionWidth * 0.5 - (self.ballSize * 0.5) + (CGFloat(self.selectedTabIndex) * self.sectionWidth)
        let ballLayerY = self.itemHeight * 0.25 - (self.ballSize * 0.5)
        self.ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: self.ballSize, height: self.ballSize)
        
        // animate ball
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.5
        animation.toValue = 1.0
        animation.duration = SETabView.settings.ballAnimationDuration
        animation.fillMode = .both
        animation.beginTime = CACurrentMediaTime() + SETabView.settings.scaleBallDelayTime
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        self.ballLayer.add(animation, forKey: nil)
        
    }

    private func translateBallTriangular() {
        
        let ballLayerX = self.sectionWidth * 0.5 - (self.ballSize * 0.5) + (CGFloat(self.selectedTabIndex) * self.sectionWidth)
        let ballLayerY = self.itemHeight * 0.25 - (self.ballSize * 0.5)
        
        let previousPosition = self.ballLayer.position
        let newPosition = CGPoint(x: ballLayerX + self.ballSize / 2, y: ballLayerY + self.ballSize / 2)
        let midPostion = CGPoint(x: (newPosition.x + previousPosition.x) * 0.5 , y: self.bounds.height * 1.5)
        
        self.ballLayer.position = newPosition
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [previousPosition, midPostion, newPosition].map{NSValue(cgPoint: $0)}
        animation.keyTimes = [0.0, 0.5, 1.0]
        animation.duration = SETabView.settings.ballAnimationDuration
        animation.fillMode = .forwards
        animation.timingFunctions = [seEaseIn, seEaseOut]
        
        self.ballLayer.add(animation, forKey: nil)
        
    }
    
    private func translateBallLinear() {
        
        let ballLayerX = self.sectionWidth * 0.5 - (self.ballSize * 0.5) + (CGFloat(self.selectedTabIndex) * self.sectionWidth)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = ballLayerX + self.ballSize / 2
        animation.duration = SETabView.settings.ballAnimationDuration
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        animation.timingFunction = seEaseInOut
        
        self.ballLayer.add(animation, forKey: nil)
    }
    
    private func rotateBall() {
        
        let rotatePaths = self.createRotateBallPaths()
        
        let hideBallAnimation = CAKeyframeAnimation(keyPath: "position")
        hideBallAnimation.path = rotatePaths["hide"]
        hideBallAnimation.duration = SETabView.settings.ballAnimationDuration
        hideBallAnimation.isRemovedOnCompletion = false
        hideBallAnimation.timingFunction = seEaseInOut
        
        let showBallAnimation = CAKeyframeAnimation(keyPath: "position")
        showBallAnimation.path = rotatePaths["show"]
        showBallAnimation.duration = SETabView.settings.ballAnimationDuration
        showBallAnimation.isRemovedOnCompletion = false
        showBallAnimation.fillMode = .both
        showBallAnimation.timingFunction = seEaseInOut
        
        self.ballLayerReplica?.add(hideBallAnimation, forKey: nil)
        self.ballLayer.add(showBallAnimation, forKey: nil)
        
        
        
    }
    
    private func translateShapeLayer() {
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = CGFloat(self.selectedTabIndex) * self.sectionWidth + self.tabShapeLayer.position.x
        animation.duration = SETabView.settings.switchTabAnimationDuration
        animation.fillMode = .both
        animation.timingFunction = seEaseInOut
        animation.isRemovedOnCompletion = false
        self.tabShapeLayer.add(animation, forKey: nil)
        
    }
    
    private func changeTintColor() {
        
        // select
        let upMovement = CABasicAnimation(keyPath: "position.y")
        upMovement.toValue = (self.iconSize / 2)
        upMovement.fillMode = .both
        upMovement.isRemovedOnCompletion = false
        upMovement.duration = SETabView.settings.changeTintColorAnimationDuration
        upMovement.timingFunction = seEaseInOut
        
        let select = CABasicAnimation(keyPath: "backgroundColor")
        select.toValue = SETabView.settings.selectedTabTintColor.cgColor
        select.fillMode = .both
        select.isRemovedOnCompletion = false
        select.duration = SETabView.settings.changeTintColorAnimationDuration
        select.timingFunction = seEaseInOut
        
        // unselect
        let downMovement = CABasicAnimation(keyPath: "position.y")
        downMovement.toValue = (self.sectionHeight / 2)
        downMovement.fillMode = .both
        downMovement.isRemovedOnCompletion = false
        downMovement.duration = SETabView.settings.changeTintColorAnimationDuration
        downMovement.timingFunction = seEaseInOut
        
        let unselect = CABasicAnimation(keyPath: "backgroundColor")
        unselect.toValue = SETabView.settings.unselectedTabTintColor.cgColor
        unselect.fillMode = .both
        unselect.isRemovedOnCompletion = false
        unselect.duration = SETabView.settings.changeTintColorAnimationDuration
        unselect.timingFunction = seEaseInOut
        
        // apply animations
        self.tabImageLayers
          .enumerated()
          .filter({ $0.offset != Int(self.selectedTabIndex) })
          .forEach({
            
            $0.element.add(unselect, forKey: nil)
            $0.element.add(downMovement, forKey: nil)
            
            
          })

        let selectedTabButton = self.tabImageLayers[Int(self.selectedTabIndex)]
        selectedTabButton.add(select, forKey: nil)
        selectedTabButton.add(upMovement, forKey: nil)
        
    }
    
    private func morphShapeLayer() {
        
        let morphAnimation = CAKeyframeAnimation(keyPath: "path")
        morphAnimation.values = [self.invertedPlateauPath!, self.rectangularMorphPath!, self.bumpPath!, self.bumpPath!, self.rectangularMorphPath!, self.invertedPlateauPath!]
        morphAnimation.keyTimes = [0.0, 0.25, 0.4, 0.65, 0.85, 1.0]
        morphAnimation.timingFunctions = [seEaseIn, seEaseOut, CAMediaTimingFunction(name: .linear), seEaseIn, seEaseOut]
        morphAnimation.duration = SETabView.settings.switchTabAnimationDuration
        morphAnimation.fillMode = .both
        
        self.tabShapeLayer.add(morphAnimation, forKey: nil)
        
    }
    
    // MARK: Functions: Touches
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let x = touches.first?.location(in: self).x else {
            return
        }
        let index = floor(x/sectionWidth)
        self.delegate?.didSelectTab(at: Int(index))
    }
    
}
