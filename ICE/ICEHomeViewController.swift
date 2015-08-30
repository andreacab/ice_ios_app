//
//  ViewController.swift
//  ICE
//
//  Created by Andrea Cabral on 26.10.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit

class ICEHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let ICETabBarController : UITabBarController = self.tabBarController
        {
            println("Home View Controller has a parent tab controller yeahh!")
        }
        else
        {
            println("cannot find the tab bar controller snifff..")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

