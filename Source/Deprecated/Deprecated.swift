//
//  Deprecated.swift
//  Pods-SETabView_Example
//
//  Created by Vinayak Eshwa on 20/03/22.
//

import UIKit

@available(iOS, obsoleted: 2.0.0, renamed: "SETabViewController")
open class SEViewController { }

@available(iOS, obsoleted: 2.0.0, renamed: "SETabItemProvider")
public protocol SETabItem { }

public extension SETabViewController {
    @available(iOS, obsoleted: 2.0.0, message: "Use setTabColors(backgroundColor:ballColor:tintColor:unselectedItemTintColor:barTintColor:) instead")
    func setTabSettings(tabColor: UIColor, ballColor: UIColor, selectedTabTintColor: UIColor, deselectedTabTintColor: UIColor, animationDuration: Double) { }
    
    @available(iOS, obsoleted: 2.0.0, message: "Use setViewControllers(_:) instead")
    func setViewControllers(_ viewControllers: [UIViewController], initialSelectedIndex: Int, animationType: AnimationType) { }
}
