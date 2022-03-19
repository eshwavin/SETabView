//
//  FourthViewController.swift
//  SETabView_Example
//
//  Created by Srivinayak Chaitanya Eshwa on 13/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SETabView

class FourthViewController: UIViewController, SETabItemProvider {
    
    var seTabBarItem: UIImage? {
           return UIImage(named: "fourth")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
