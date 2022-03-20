//
//  SETabViewDelegate.swift
//  SETabViewControl
//
//  Created by Srivinayak Chaitanya Eshwa on 10/08/20.
//  Copyright © 2020 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import Foundation

protocol AnimatedTabViewDelegate: AnyObject {
    func didSelectTab(at index: Int)
    func changeBottomFillerViewColor()
}
