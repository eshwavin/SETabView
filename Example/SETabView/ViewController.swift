//
//  ViewController.swift
//  SETabView
//
//  Created by eshwavin on 03/13/2020.
//  Copyright (c) 2020 eshwavin. All rights reserved.
//

import UIKit
import SETabView

class ViewController: SETabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set tab bar look
        setTabColors(backgroundColor: .white, ballColor: .white, tintColor: .black, unselectedItemTintColor: .gray, barTintColor: .clear)
        
        // set view controllers
        setViewControllers(getViewControllers())
        
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

