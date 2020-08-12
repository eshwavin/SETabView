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
        
        // set tab bar look
        setTabSettings(tabColor: UIColor.black, ballColor: UIColor.black, selectedTabTintColor: UIColor.white, deselectedTabTintColor: UIColor.gray, animationDuration: 1)
        
        // set view controllers
        setViewControllers(getViewControllers(), initialSelectedTabIndex: 0, animationType: .holeBall3)
        
    }
    
    private func getViewControllers() -> [UIViewController] {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return [
            storyboard.instantiateViewController(withIdentifier: "firstVC"),
            storyboard.instantiateViewController(withIdentifier: "secondVC"),
            storyboard.instantiateViewController(withIdentifier: "thirdVC"),
            storyboard.instantiateViewController(withIdentifier: "fourthVC"),
            storyboard.instantiateViewController(withIdentifier: "fifthVC")
        ]
        
        
    }

}

