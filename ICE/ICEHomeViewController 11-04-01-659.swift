//
//  ICEHomeViewController.swift
//  ICE
//
//  Created by Andrea Cabral on 30.10.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit
import CoreData

class ICEHomeViewController: UIViewController {

    @IBOutlet weak var ICEHomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myTBC = self.tabBarController
        var myTBVCs = myTBC!.viewControllers as [UIViewController]
        var myScanVC = myTBVCs[2] as ICEScanViewController
        //myScanVC.delegate = self
        
        uploadScansFromPersistentStore()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 /*
    func uploadScansFromPersistentStore () {
        let coreDataStack = CoreDataStack()
        let fetchRequest = NSFetchRequest(entityName: "ICEScan")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors!.append(sortDescriptor)
        var error : NSError? = NSError()
        if error != nil {
            let arrayOfICEScan : [ICEScan] = coreDataStack.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as [ICEScan]
            println("the name of the first image is \(arrayOfICEScan[0].scanName)" )

        } else {
            println("could not execut the fetch request")
        }
    }
*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

/*
    //Protocol ICEScanViewControllerDelegate methods
    func ICEScanDoneFromViewController(viewController: UIViewController, withImage: ICEScan) {
        
        self.ICEHomeLabel.text = withImage.imageName
    }
*/

}
