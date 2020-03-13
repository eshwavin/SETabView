//
//  ViewController.swift
//  SETabView
//
//  Created by eshwavin on 03/13/2020.
//  Copyright (c) 2020 eshwavin. All rights reserved.
//

import UIKit
import SETabView

class ViewController: SEViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers()
        
    }
    
    private func setViewControllers() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = storyboard.instantiateViewController(withIdentifier: "firstVC")
        let secondVC = storyboard.instantiateViewController(withIdentifier: "secondVC")
        let thirdVC = storyboard.instantiateViewController(withIdentifier: "thirdVC")
        let fourthVC = storyboard.instantiateViewController(withIdentifier: "fourthVC")
        
        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        
    }

    override func setTabSettings() {
        // customise tab bar colors (always before setting view controllers)
        SETabView.settings.tabColor = UIColor.black
        SETabView.settings.ballColor = UIColor.black
        SETabView.settings.selectedTabTintColor = UIColor.white
        SETabView.settings.unselectedTabTintColor = UIColor.gray
        
        // customise animation duration (always before setting view controllers)
        SETabView.settings.animationDuration = 1.5 // optimal duration = 1.5
    }
    
    override func setAnimationType() {
        self.animationType = .holeBall3 // defaults to .holeBall3
    }

}

