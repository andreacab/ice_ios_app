//
//  ICEScanViewController.swift
//  ICE
//
//  Created by Andrea Cabral on 26.10.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit
import Foundation
import CoreFoundation
import MobileCoreServices
import CoreData

class ICEScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//////////********** 1 VARIABLES **********//////////
// MARK: 1 Variables
// MARK: 1.1 Stored Global Properties
    var scanImage : UIImage?
    var folderForSavedImages : ICEFolder?
    
// MARK: 1.2 UIImagePickerController variables
    var imagePickerController = UIImagePickerController()
    @IBOutlet weak var takePictureButton: UIButton!
    
    
//////////********** 2 METHODS **********//////////
// MARK: 2 Methods
// MARK: 2.1 ICEScanViewController General Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //listnening to notification take picture
//        let notificationCenter = NSNotificationCenter.defaultCenter()
//        notificationCenter.addObserver(self, selector: "imagePickerControllerDidCaptureItemNotification:", name: nil, object: nil)
        println("ICEScanVC: viewDidLoad: called")
    }
    
    override func didReceiveMemoryWarning() {
        println("Memory warning !!!!!")
    }
    
//  override func viewDidDisappear(animated: Bool) {
//      println("camera picker disappeared")
//    }
    
    //func to create photo controller
    func startCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            self.imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera)!
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.showsCameraControls = true
            self.imagePickerController.delegate = self
            self.presentViewController(self.imagePickerController, animated: true, completion: nil)
        }
        println("ICEScanVC: startCamera: called")
    }
    
//////////////// 2.2 UIImagePickerController delegate methods //////////////////
// MARK: 2.2 UIImagePickerController delegate methods
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {

        picker.dismissViewControllerAnimated(true, completion: nil)
        //if cancel button pressed get back to home tab
        println("ICEScanVC: imagePickerControllerDidCancel: called")
    }
    
    func  imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        println("in did finish picking media with info!")
        let mediaType: CFString = info[UIImagePickerControllerMediaType]! as! CFString
        
        var originalImage : UIImage? = UIImage()
        var editedImage : UIImage? = UIImage()
        var imgToSave : UIImage? = UIImage()
        var comparisonResult = CFStringCompare(mediaType, kUTTypeImage, CFStringCompareFlags.allZeros)
        
        if (comparisonResult == CFComparisonResult.CompareEqualTo)
        {
            editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            if(editedImage != nil) {
                imgToSave = editedImage
            }
            else {
                imgToSave = originalImage
            }
        }
        
        self.scanImage = imgToSave!
        
//        var name : String = "image_1"
//        self.insertEntryICEScan(name)
        
        //Save image to photo album
        //UIImageWriteToSavedPhotosAlbum(imgToSave!, nil, nil, nil)
        

        picker.dismissViewControllerAnimated(true, completion: nil)
        
        //once picker dismissed, select folder view controller
        let myUIViewControllers : [UIViewController] = self.tabBarController!.viewControllers as! [UIViewController]
        self.tabBarController!.selectedViewController = myUIViewControllers[1]
        self.getTitleForScan()
        println("ICEScanVC: didFinishPickingImageWithInfo: called")
    }
    

//////////////// 2.3 Core Data Utility methods //////////////////
// MARK: 2.3 Core Data Utility Methods
    func insertEntryICEScan(name: String) {
        let coreDataStack = CoreDataStack()
        
        println("my managed objects Context is \(coreDataStack.managedObjectContext!)")
        
        let myManagedObjectContext : NSManagedObjectContext = coreDataStack.managedObjectContext!
            println("managedContext is : \(myManagedObjectContext)")
            
        let entity = NSEntityDescription.entityForName("ICEScan", inManagedObjectContext: myManagedObjectContext)
            
        let newICEScan = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: myManagedObjectContext)
       
        newICEScan.setValue(name, forKey: "scanName")
        
        var error: NSError?
        if !myManagedObjectContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        println("ICEScanVC: insertEntryICEScan: called")
    }
    
/*  //update a savec  entry
    func updateEntryFromICEScan() {
    }
*/
    
/*  //delete entry
    func deleteEntryFromICEScan() {
}
*/
    
    //////////////// 2.4 Notifications methods //////////////////
    // MARK: 2.4 Notifications Methods
    func imagePickerControllerDidCaptureItemNotification(notification: NSNotification) {
        println("notification name is \(notification.name) sent by object \(notification.object!.description)")
    }
    
    //////////////// 2.5 Divers //////////////////
    // MARK: 2.5 Divers
    func buttonTakePicturePressed () {
        println("Button was pressed youhouuuu!!!")
        println("ICEScanVC: buttonTakePicturePressed: called")
    }
    
//    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
//        if let name = identifier {
//            switch name {
//            case "EditScan":
//                println("about to show edit scan view controller...")
//                let ICEStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//                var myICEScanEditViewController: ICEScanEditViewController! = ICEStoryBoard.instantiateViewControllerWithIdentifier("ICEScanEditViewController") as ICEScanEditViewController
//                self.presentViewController(myICEScanEditViewController, animated: true, completion: nil)
//            default:
//                println("no segue found for identifier: \"\(identifier)\"")
//            }
//        } else {
//            println("no identifier string passed to method perform segue..")
//        }
//    }
    
    func getTitleForScan() {
        var myAlertController = UIAlertController(title: "Save as ?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        //Add text field to the alert
        var alertTextField = UITextField()
        myAlertController.addTextFieldWithConfigurationHandler { (alertTextField) -> Void in
            alertTextField.placeholder = "Enter a scan name"
            alertTextField.clearsOnBeginEditing = true
            alertTextField.clearsOnInsertion = true
            alertTextField.clearButtonMode = UITextFieldViewMode.UnlessEditing
        }
        
        var myAction1 = UIAlertAction(title: "Done", style: .Default) { (alertAction) -> Void in
            let textField = myAlertController.textFields![0]as! UITextField
            self.saveScanName(textField)
        }
        
        var myAction2 = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        myAlertController.addAction(myAction2)
        myAlertController.addAction(myAction1)

        self.parentViewController?.presentViewController(myAlertController, animated: true, completion: nil)
        println("ICEScanVC: getTitleForScan: called")

    }
    
    func saveScanName (textField: UITextField) {
        self.insertEntryICEScan(textField.text)
        println("the name you entered is: \(textField.text)")
        println("ICEScanVC: saveScanName: called")
    }
}
















