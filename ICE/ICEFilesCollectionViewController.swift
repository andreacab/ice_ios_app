//
//  ICEFilesCollectionViewController.swift
//  ICE
//
//  Created by Andrea Cabral on 18.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit
import CoreData

let reuseIdentifierFileCell = "ICEFileCell"

class ICEFilesCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK : Variables
    var ICEFileFetchedResultsController: NSFetchedResultsController?
    var ICEFileCoreDataStack: CoreDataStack?
    var aICEFolder: ICEFolder?
    var ICEFilesTotalItems: Int?
    var aICEFolderScansSortedArray: [ICEScan]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        println("ICEFilesCVC - viewDidLoad: called")
    }
    
    override func viewDidAppear(animated: Bool) {
        println("ICEFilesCVC - viewDidAppear: called")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIFetchedResultsControllerDelegat
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Delete:
                println("ICEFilesCVC - didChangeObject: Delete: called")
                self.collectionView!.deleteItemsAtIndexPaths([indexPath!])
            case .Update:
                println("ICEFilesCVC - didChangeObject: Update: called")

                var aFileCell = collectionView(self.collectionView!, cellForItemAtIndexPath: indexPath!) as! ICEFileCell
                self.configureFileCell(aFileCell, atIndexPath: indexPath!)
            case .Move:
                println("ICEFilesCVC - didChangeObject: Move: called")

                self.collectionView!.moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            case .Insert:
                println("ICEFilesCVC - didChangeObject: Insert: called")
                println("indexpath is \(indexPath)")
                println("new index path is \(newIndexPath)")
                self.collectionView!.insertItemsAtIndexPaths([newIndexPath!])
        }
        self.collectionView!.reloadData()
    }
    
    // MARK: UICollectoinViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        println("ICEFilesCVC - sizeForItemAtIndexPath: called")
        var aCellSize = CGSize(width: 180.0, height: 180.0)
        return aCellSize
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        println("ICEFilesCVC - numberOfSection: called")
        return self.ICEFileFetchedResultsController!.sections!.count
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        println("ICEFilesCVC - numberOfItemsInSection: called")

        let sections = self.ICEFileFetchedResultsController!.sections!
        let sectionInfo: NSFetchedResultsSectionInfo = sections[section] as! NSFetchedResultsSectionInfo
        self.ICEFilesTotalItems = sectionInfo.numberOfObjects
        return sectionInfo.numberOfObjects + 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        println("ICEFilesCVC - cellForItemAtIndexPath: called")

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierFileCell, forIndexPath: indexPath) as! ICEFileCell
        
        //cell.label.text = self.aICEFolderScansSortedArray![indexPath.row].name
        // Configure the cell
        self.configureFileCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureFileCell(fileCell: ICEFileCell, atIndexPath indexPath: NSIndexPath) {
        println("ICEFilesCVC - configureFileCell: called")

        if (indexPath.row == self.ICEFilesTotalItems) {
            var origin = CGPoint(x: 0.0, y: 0.0)
            var rect = CGRect(origin: origin, size: fileCell.frame.size)
            var addCellCustomView = UIView(frame: rect)
            addCellCustomView.alpha = 0.5
            addCellCustomView.backgroundColor = UIColor.blueColor()
            fileCell.label.text = "Scan"
            fileCell.contentView.addSubview(addCellCustomView)
        } else {
            var aICEScanRecord = self.ICEFileFetchedResultsController!.objectAtIndexPath(indexPath) as! ICEScan
            fileCell.label.text = aICEScanRecord.name
        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("ICEFilesCVC - didSelectItemAtIndexPath: called")

        if (indexPath.row == self.ICEFilesTotalItems) {
            self.getNameForScanEntity()

        } else {
            println("show file detail")
        }
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    // MARK : Divers
    func getNameForScanEntity() {
        println("ICEFilesCVC - getNameForScanEntity: called")

        let ICEScanAlertController = UIAlertController(title: "New Scan", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        ICEScanAlertController.addTextFieldWithConfigurationHandler { (textfield: UITextField!) -> Void in
            textfield.placeholder = "Enter scan name.."
        }
        let ICEScanCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let ICEScanSaveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            var textfieldArray = ICEScanAlertController.textFields as! [UITextField]?
            if let array = textfieldArray {
                if (array[0].text != "") {
                    self.saveNewScanEntityWithName(array[0].text)
                } else {
                    array[0].placeholder = "no name entered yet! Please enter a name"
                }
            }
        }
        ICEScanAlertController.addAction(ICEScanCancelAction)
        ICEScanAlertController.addAction(ICEScanSaveAction)
        self.presentViewController(ICEScanAlertController, animated: true, completion: nil)
    }
    
    func saveNewScanEntityWithName(name: String) {
        println("ICEFilesCVC: saveNewScanEntityWithName: called")
        var aNewScanEntity = NSEntityDescription.entityForName("ICEScan", inManagedObjectContext: self.ICEFileCoreDataStack!.managedObjectContext!)
        if let entity = aNewScanEntity {
            var aNewScanRecord = ICEScan(entity: entity, insertIntoManagedObjectContext: self.ICEFileCoreDataStack!.managedObjectContext!)
            aNewScanRecord.name = name
            aNewScanRecord.date = NSDate()
            aNewScanRecord.folder = self.aICEFolder!
        } else {
            println("could not create Scan entity...")
        }
        
        var saveError: NSError?
        self.ICEFileCoreDataStack!.managedObjectContext!.save(&saveError)
        
        if let error = saveError {
            println("error while saving new ICEScan object in managedObjectContext...")
        }
    }
     /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
}
