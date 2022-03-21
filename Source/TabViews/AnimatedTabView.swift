//
//  AnimatedTabView.swift
//  SETabView
//
//  Created by Vinayak Eshwa on 21/03/22.
//

import UIKit

class AnimatedTabView: UIView, AnimatedTabViewProtocol {
    // MARK: Properties: Tab
    
    /// Specifies the current tab index selected
    var selectedTabIndex: Int = 0 {
        didSet {
            moveToSelectedTab()
        }
    }
    var previousTabIndex: Int = -1
    
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
    
    var numberOfTabs: Int {
        return tabImages.count
    }
    
    /// the object that acts as the delegate of the SETabView
    public weak var delegate: AnimatedTabViewDelegate?
    
    // MARK: Properties: Layer
    var tabShapeLayer = SEShapeLayer()
    let ballLayer = SELayer()
    var tabImageLayers = [SELayer]()

    // MARK: Properties: Size
    
    var sectionWidth: CGFloat {
        bounds.width / CGFloat(numberOfTabs)
    }
    
    var sectionHeight: CGFloat {
        bounds.height
    }
    
    var itemWidth: CGFloat {
        sectionWidth > 100 ? 100: sectionWidth
    }
    
    var ballSize: CGFloat {
        itemWidth / 2.0
    }
    
    var iconSize: CGFloat {
        ballSize / 1.8
    }
    
    var itemHeight: CGFloat {
        let height = bounds.height
        return height > ballSize ? ballSize : height
    }
    
    var heightScalingFactor: CGFloat {
        itemWidth / 100
    }
    
    // MARK: Properties: Misc
    public var isSetup = false
    public var closureAfterSetup: (() -> Void)?
    private var isTraitCollectionChangeSetup = false

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
        
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupTabLayers()
        if !isSetup {
            isSetup = true
            closureAfterSetup?()
            closureAfterSetup = nil
        }
        else {
            layoutSubviewsAfterSetup()
        }
        
    }
    
    func layoutSubviewsAfterSetup() {
        translateShapeLayer()
    }
}

// MARK: AnimatedTabView functions
extension AnimatedTabView {

    func applyColors() {
        setTabBarColors()
        changeSelectedTintColor(animated: false)
        changeUnselectedTintColor(animated: false)
    }
    
    func tabTintColorDidChange() {
        changeSelectedTintColor(animated: false)
    }
    
    func backgroundColorDidChange() {
        setTabShapeLayerColor()
        delegate?.changeBottomFillerViewColor()
    }
    
    func setTabShapeLayerColor() {
        tabShapeLayer.fillColor = SETabSettings.current.backgroundColor.cgColor
    }
    
    func ballColorDidChange() {
        setBallColor()
    }
    
    /// needs to be overriden
    @objc func setBallColor() {
        ballLayer.backgroundColor = SETabSettings.current.ballColor.cgColor
    }
    
    func unselectedItemTintColorDidChange() {
        changeUnselectedTintColor(animated: false)
    }
    
    func barTintColorDidChange() {
        // do nothing
    }
    
    func changeSelectedTintColor(animated: Bool =  true) {
        tabImageLayers[selectedTabIndex].highlight(inDuration: animated ? SETabSettings.current.changeTintColorAnimationDuration : 0)
    }
    
    func changeUnselectedTintColor(animated: Bool =  true) {
        tabImageLayers
            .enumerated()
            .filter({ $0.offset != Int(selectedTabIndex) })
            .forEach({
                
                $0.element.removeHighlight(inDuration: animated ? SETabSettings.current.changeTintColorAnimationDuration : 0)
                
            })
    }


}

// MARK: Setup

extension AnimatedTabView {
    
    // sets up different layers of the tabBar
    @objc func setupView() {
     
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
    
    @objc func setupTabLayers() {
        
    }
    
    func setupTabImagePositions() {
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

extension AnimatedTabView {
    
    private func createHolePath() -> CGPath {
        
        let startOffset = ((sectionWidth - itemWidth) / 2)
        let coverOffset = CGFloat(numberOfTabs - 1) * sectionWidth
        
        return SEPathProvider.getHolePath(for: bounds, startOffset: startOffset, coverOffset: coverOffset, itemWidth: itemWidth, sectionHeight: sectionHeight, heightScalingFactor: heightScalingFactor)
        
    }

}

// MARK: Animations

extension AnimatedTabView {
    
    private func moveToSelectedTab() {
        if (selectedTabIndex == previousTabIndex) {
            previousTabIndex = selectedTabIndex
            return
        }

        performAnimations()
        
        if previousTabIndex == -1 {
            applyColors()
        }
        else {
            switchSelectionsInTabLayers()
        }
        
        previousTabIndex = selectedTabIndex
    }
    
    @objc func performAnimations() {
        translateShapeLayer()
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
}

// MARK: Functions: Touches

extension AnimatedTabView {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let x = touches.first?.location(in: self).x else {
            return
        }
        let index = floor(x/sectionWidth)
        delegate?.didSelectTab(at: Int(index))
    }
}
