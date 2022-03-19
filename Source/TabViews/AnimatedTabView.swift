//
//  TabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 31/07/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

protocol AnimatedTabView: UIView {
    
    var tabImages: [UIImage] { get set }
    var selectedTabIndex: Int { get set }
    var delegate: AnimatedTabViewDelegate? { get set }
    
    var isSetup: Bool { get set }
    var closureAfterSetup: (() -> Void)? { get set }
    
    func applyColors()
    func tabTintColorDidChange()
    func backgroundColorDidChange()
    func ballColorDidChange()
    func unselectedItemTintColorDidChange()
    func barTintColorDidChange()
}

extension AnimatedTabView {
    
    func changeSelectedTintColor(animated: Bool =  true, tabImageLayers: [SELayer]) {
        tabImageLayers[selectedTabIndex].highlight(inDuration: animated ? SETabSettings.current.changeTintColorAnimationDuration : 0)
    }
    
    func changeUnselectedTintColor(animated: Bool =  true, tabImageLayers: [SELayer]) {
        tabImageLayers
            .enumerated()
            .filter({ $0.offset != Int(selectedTabIndex) })
            .forEach({
                
                $0.element.removeHighlight(inDuration: animated ? SETabSettings.current.changeTintColorAnimationDuration : 0)
                
            })
    }
    
}

public protocol AnimatedTabViewProperties {
    var tintColor: UIColor { get set }
    var backgroundColor: UIColor { get set }
    var ballColor: UIColor { get set }
    var unselectedItemTintColor: UIColor { get set }
    var barTintColor: UIColor { get set }
    var animationDuration: Double { get set }
}
