//
//  ICETabBarController.swift
//  ICE
//
//  Created by Andrea Cabral on 30.10.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit

class ICETabBarController: UITabBarController, UITabBarControllerDelegate {

    //VARIABLES
    
    //METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set delegate for tabbarViewController
        self.delegate = self
        
        if let myTabBarViewControllers = self.viewControllers {
            
            for item in myTabBarViewControllers {
                
                let myViewController = item as! UIViewController
                if myViewController.title == "ICEFoldersNavigationController" {
                   
                    self.selectedViewController = myViewController
                }
            }
        }
        else {
            println("no tab bar items (viewcontrollers) found")
        }
        println("ICETabBarVC: viewDidLoad: called")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        println("ICETabBarVC: shouldSelectViewController: called")
        switch viewController.title! {
            
            case "ICEScanViewController":
                println("select scan VC!")
                let myICEScanViewController: ICEScanViewController = viewController as! ICEScanViewController
                tabBarController.selectedViewController = myICEScanViewController
                myICEScanViewController.startCamera()
                return true
            
            case "ICEFoldersNavigationController":
                println("select folders VC!")
                tabBarController.selectedViewController = viewController
                return true
            
            case "ICESyncViewController":
                println("select sync VC!")
                tabBarController.selectedViewController = viewController
                return true
            
            default:
                println("tab bar item does not exist")
                return false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        
//        // Pass the selected object to the new view controller.
//    }

}
