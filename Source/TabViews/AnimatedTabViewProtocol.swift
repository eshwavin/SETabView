//
//  TabView.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 31/07/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

protocol AnimatedTabViewProtocol: UIView {
    
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

public protocol AnimatedTabViewProperties {
    var tintColor: UIColor { get set }
    var backgroundColor: UIColor { get set }
    var ballColor: UIColor { get set }
    var unselectedItemTintColor: UIColor { get set }
    var barTintColor: UIColor { get set }
}
