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
    var delegate: SETabViewDelegate? { get set }
    
    var isSetup: Bool { get set }
    var closureAfterSetup: (() -> Void)? { get set }
    
}
