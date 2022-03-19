//
//  InvertedPlateauTabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 11/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

final class InvertedPlateauTabView: UIView, AnimatedTabView {
    
    // MARK: Properties: Tab
    
    /// Specifies the current tab index selected
    public var selectedTabIndex: Int = 0 {
        didSet {
            moveToSelectedTab()
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
            addTabImages()
        }
    }
    
    private var numberOfTabs: Int {
        return tabImages.count
    }
    
    /// the object that acts as the delegate of the SETabView
    public weak var delegate: AnimatedTabViewDelegate?
    
    // MARK: Properties: Layer
    private var tabShapeLayer = SEShapeLayer()
    private let ballLayer = SELayer()
    private var tabImageLayers = [SELayer]()
    
    // MARK: Properties: Size
    
    private var sectionWidth: CGFloat {
        bounds.width / CGFloat(numberOfTabs)
    }
    
    private var sectionHeight: CGFloat {
        bounds.height
    }
    
    private var itemWidth: CGFloat {
        sectionWidth > 100 ? 100: sectionWidth
    }
    
    private var ballSize: CGFloat {
        itemWidth / 2.0
    }
    
    private var iconSize: CGFloat {
        ballSize / 1.8
    }
    
    private var itemHeight: CGFloat {
        let height = bounds.height
        return height > ballSize ? ballSize : height
    }
    
    private var heightScalingFactor: CGFloat {
        itemWidth / 100
    }
    
    // MARK: Properties: Misc
    public var isSetup = false
    public var closureAfterSetup: (() -> Void)?
    
    // MARK: Functions: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: Functions: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTabLayers()
        if !isSetup {
            isSetup = true
            closureAfterSetup?()
            closureAfterSetup = nil
        }
        else {
            translateShapeLayer()
        }
    }
    
}

// MARK: AnimatedTabView functions
extension InvertedPlateauTabView {
    
    func applyColors() {
        setTabBarColors()
        setTabBarColors()
        changeSelectedTintColor(animated: false, tabImageLayers: tabImageLayers)
        changeUnselectedTintColor(animated: false, tabImageLayers: tabImageLayers)
    }
    
    func tabTintColorDidChange() {
        changeSelectedTintColor(animated: false, tabImageLayers: tabImageLayers)
    }
    
    func backgroundColorDidChange() {
        setTabShapeLayerColor()
    }
    
    private func setTabShapeLayerColor() {
        tabShapeLayer.fillColor = SETabSettings.current.backgroundColor.cgColor
    }
    
    func ballColorDidChange() {
        setBallColor()
    }
    
    private func setBallColor() {
        ballLayer.backgroundColor = SETabSettings.current.ballColor.cgColor
    }
    
    func unselectedItemTintColorDidChange() {
        changeUnselectedTintColor(animated: false, tabImageLayers: tabImageLayers)
    }
    
    func barTintColorDidChange() {
        // do nothing
    }
    
}

// MARK: Setup

extension InvertedPlateauTabView {
    
    // sets up different layers of the tabBar
    private func setupView() {
        
        layer.addSublayer(ballLayer)
        
        tabShapeLayer.lineWidth = 0.5
        tabShapeLayer.position = CGPoint(x: 0, y: 0) // 10, 10 originally
        backgroundColor = UIColor.clear
        layer.addSublayer(tabShapeLayer)
        
        previousTabIndex = 0
        
        setTabBarColors()
        
    }
    
    // adds the images as layers to the tabBar
    private func addTabImages() {
        tabImages.map { (image) -> CALayer in
            let maskLayer = CALayer()
            maskLayer.contents = image.cgImage
            maskLayer.contentsGravity = .resizeAspect
            let imageLayer = SELayer()
            imageLayer.mask = maskLayer
            tabImageLayers.append(imageLayer)
            return imageLayer
        }.forEach(layer.addSublayer(_:))
    }
    
    private func setupTabLayers() {
        
        // setup ball layer
        let ballLayerX = sectionWidth * 0.5 - (ballSize * 0.5) + (CGFloat(selectedTabIndex) * sectionWidth)
        let ballLayerY = itemHeight * 0.25 - (ballSize * 0.5)
        ballLayer.frame = CGRect(x: ballLayerX, y: ballLayerY, width: ballSize, height: ballSize)
        ballLayer.cornerRadius = ballSize / 2.0
        
        // setup shape layer
        tabShapeLayer.frame = bounds
        tabShapeLayer.path = createInvertedPlateauPath(withOffset: true)
        
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
    
    private func moveToSelectedTab() {
        if (selectedTabIndex == previousTabIndex) {
            previousTabIndex = selectedTabIndex
            return
        }
        translateShapeLayer()
        translateBallTriangular()
        
        if previousTabIndex == -1 { // first selection needs all colors set
            applyColors()
        }
        else { // subsequent selections
            switchSelectionsInTabLayers()
        }
        
        previousTabIndex = selectedTabIndex
    }
    
    private func switchSelectionsInTabLayers() {
        if previousTabIndex >= 0 {
            tabImageLayers[previousTabIndex].removeHighlight()
            tabImageLayers[previousTabIndex].moveDown(to: sectionHeight / 2)
        }
        
        tabImageLayers[selectedTabIndex].highlight()
        tabImageLayers[selectedTabIndex].moveUp(to: iconSize / 2)
    }
    
    private func translateShapeLayer() {
        
        let toValue = CGFloat(selectedTabIndex) * sectionWidth + tabShapeLayer.position.x
        tabShapeLayer.translate(to: toValue)
    }
        
    private func setTabBarColors() {
        setBallColor()
        setTabShapeLayerColor()
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

// MARK: Touches

extension InvertedPlateauTabView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let x = touches.first?.location(in: self).x else {
            return
        }
        let index = floor(x/sectionWidth)
        delegate?.didSelectTab(at: Int(index))
    }
}
