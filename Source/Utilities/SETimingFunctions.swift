//
//  TimingFunctions.swift
//  SETabView
//
//  Created by Vinayak Eshwa on 20/03/22.
//

import UIKit

struct SETimingFunction {
    public static let seEaseIn = CAMediaTimingFunction(controlPoints: 0.6, 0, 1, 1)
    public static let seEaseOut = CAMediaTimingFunction(controlPoints: 0, 0, 0.4, 1)
    public static let seEaseInOut = CAMediaTimingFunction(controlPoints: 0.6, 0, 0.4, 1)
}
