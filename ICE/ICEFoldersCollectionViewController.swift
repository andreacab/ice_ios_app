//
//  ICEFolderCollectionViewController.swift
//  ICE
//
//  Created by Andrea Cabral on 18.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit
import CoreData

let reuseIdentifierFolderCell = "ICEFolderCell"

class ICEFoldersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    //Outlets
    @IBOutlet var ICEFolderCollectionView: UICollectionView!
    
    //class variables
    var ICEFolderFetchedResultsController: NSFetchedResultsController?
    var ICEFolderCoreDataStack: CoreDataStack?
    var ICEFolderSelection: NSIndexPath?
    var ICEFolderTotalItems: Int?
    var selectionMode: Bool = false

    //Class functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize Core Data Stack
        self.ICEFolderCoreDataStack = CoreDataStack()
        
        //Initialize NSFetchedResultsController
        if let coreDataStack = self.ICEFolderCoreDataStack {
            println("ICEFoldersCVC - viewDidLoad: called")
            println("core data stack is: \(coreDataStack)")

            var ICEFolderFetchRequest = NSFetchRequest(entityName: "ICEFolder")
            var ICEFolderSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
            var ICEFolderSortDescriptorArray = [ICEFolderSortDescriptor] as [NSSortDescriptor]
            ICEFolderFetchRequest.sortDescriptors = ICEFolderSortDescriptorArray
            
            self.ICEFolderFetchedResultsController = NSFetchedResultsController(fetchRequest: ICEFolderFetchRequest, managedObjectContext: coreDataStack.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
            
            
            if let fetchedResultsController = self.ICEFolderFetchedResultsController {
                println("fetched results controller is: \(fetchedResultsController)")
                fetchedResultsController.delegate = self

                var fetchedResultsError: NSError?
                fetchedResultsController.performFetch(&fetchedResultsError)
                if let error = fetchedResultsError {
                    println("ICEFoldersCVC WARINING: could not perform fetch. Error description is: \(error.localizedDescription) & error: \(error) ")
                }
                
            } else {
                println("ICEFoldersCVC WARINING: could not initialize ICEFolderFetchedResultsController")
            }
            
        } else {
            println("ICEFoldersCVC WARINING: unable to initialize ICEFolderCoreDataStack")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView.registerClass(ICEFolderCell.self, forCellWithReuseIdentifier: reuseIdentifierFolderCell)
        //self.tableView registerNib:[UINib nibWithNibName:@"foodCell" bundle:nil] forCellReuseIdentifier:@"foodCellIdentifier"];

        //self.collectionView.registerNib(UINib(nibName: "ICEFolderCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierFileCell)
        // Do any additional setup after loading the view.
        //self.setCollectionViewLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        println("ICEFoldersCVC - didReceiveMemoryWarning: called")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: NSFetchedResultsControllerDelegate
    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.ICEFolderCollectionView.
//    }
//
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        self.ICEFolderCollectionView.
//    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if (controller == self.ICEFolderFetchedResultsController) {
            switch type {
                case NSFetchedResultsChangeType.Delete:
                    println("ICEFoldersCVC - didChangeObject: Delete: called")
                    let IPArray = [indexPath!]
                    self.ICEFolderCollectionView.deleteItemsAtIndexPaths(IPArray)
            
                case NSFetchedResultsChangeType.Insert:
                    println("ICEFoldersCVC - didChangeObject: Insert: called")
                    let IPArray = [newIndexPath!]
                    self.ICEFolderCollectionView.insertItemsAtIndexPaths(IPArray)

                case NSFetchedResultsChangeType.Move:
                    println("ICEFoldersCVC - didChangeObject: Move: called")
                    self.ICEFolderCollectionView.moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!)

                case NSFetchedResultsChangeType.Update:
                    println("ICEFoldersCVC - didChangeObject: Update: called")
                    var cell: ICEFolderCell = collectionView(self.collectionView!, cellForItemAtIndexPath: indexPath!) as! ICEFolderCell
                    self.configureFolderCell(cell, atIndexPath: indexPath!)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        println("ICEFoldersCVC - numberOfSections: called")
        return self.ICEFolderFetchedResultsController!.sections!.count
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        println("ICEFoldersCVC - numberOfItems: called")
        let sections = self.ICEFolderFetchedResultsController!.sections
        let sectionInfo: NSFetchedResultsSectionInfo = sections![section] as! NSFetchedResultsSectionInfo
        self.ICEFolderTotalItems = sectionInfo.numberOfObjects
        return sectionInfo.numberOfObjects + 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        println("ICEFoldersCVC - cellForItemAtIndexPath: called")
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierFolderCell, forIndexPath: indexPath) as! ICEFolderCell
    
        self.configureFolderCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureFolderCell(folderCell: ICEFolderCell, atIndexPath indexPath: NSIndexPath) {
        println("ICEFoldersCVC - configureFolderCell: called")
        if (indexPath.row != self.ICEFolderTotalItems) {
            
            let ICEFolderRecord: ICEFolder = self.ICEFolderFetchedResultsController!.objectAtIndexPath(indexPath) as! ICEFolder
        
            folderCell.label.text = ICEFolderRecord.name
        } else {
            var origin = CGPoint(x: 0.0, y: 0.0)
            var rect = CGRect(origin: origin, size: folderCell.frame.size)
            var addCellCustomView = UIView(frame: rect)
            addCellCustomView.alpha = 0.5
            addCellCustomView.backgroundColor = UIColor.blueColor()
            
            folderCell.label.text = "Add"
            folderCell.contentView.addSubview(addCellCustomView)
        }
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    /*
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        println("ICEFoldersCVC - shouldHighlightItemAtIndexPath: called")
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    println("ICEFoldersCVC - shouldSelectItemAtIndexPath: called")
    return true
    }
    
    override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        println("ICEFoldersCVC - didHighlightItemAtIndexPath: called")
    }
    */
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("ICEFoldersCVC - didSelectItemAtIndexPath: called")

        //If last cell was pressed -> add a folder. If not present files colleciton view controller
        if (indexPath.row == self.ICEFolderTotalItems) {
            self.addFolderCellPressed()
        } else {
            let ICEFolderRecord: ICEFolder = self.ICEFolderFetchedResultsController!.objectAtIndexPath(indexPath) as! ICEFolder
            
            //initializing Files Collection View controller
            var aICEFilesCollectionViewFlowLayout = UICollectionViewFlowLayout()
            var aICEFilesCollectionViewController = ICEFilesCollectionViewController()
            aICEFilesCollectionViewController.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: aICEFilesCollectionViewFlowLayout)
            aICEFilesCollectionViewController.collectionView!.delegate = aICEFilesCollectionViewController
            aICEFilesCollectionViewController.collectionView!.dataSource = aICEFilesCollectionViewController
            aICEFilesCollectionViewController.collectionView!.registerClass(ICEFileCell.self, forCellWithReuseIdentifier: "ICEFileCell")
            aICEFilesCollectionViewController.collectionView!.backgroundColor = UIColor.blackColor()
            self.initICEFilesCollectionViewController(aICEFilesCollectionViewController, withFolderRecord: ICEFolderRecord)
            self.navigationController!.pushViewController(aICEFilesCollectionViewController, animated: true)
        }
    }
    
//    override func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        println("ICEFoldersCVC - shouldDeselectItemAtIndexPath: called")
//        return true
//    }
    
//    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        var numberOfItems = self.collectionView(self.ICEFolderCollectionView, numberOfItemsInSection: 0)
//        if (indexPath.row == numberOfItems - 1) {
//            UIAlertView(title: "you did it!", message: "Add button was pressed :)", delegate: nil, cancelButtonTitle: "Great!").show()
//        }
//        println("ICEFoldersCVC - didDeselectItemAtIndexPath: called")
//    }
    
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    /*
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        //used to update or suppress folder
    }
*/
    
    // MARK: UICollectionViewDelegateFlowLayout
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        let cellSize = CGSize(width: 90.0, height: 90.0)
//        return cellSize
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 25.0, left: 10.0, bottom: 0.0, right: 10.0)
//    }
    
//    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        <#code#>
//    }
//    
//    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }
    
    //MARK : Core Data Helper Methods
    
    
    func saveNewFolderEntityWithName(name: String) {
        println("ICEFoldersCVC - saveNewFolderEntityWithName: called")

        var newFolderEntity = NSEntityDescription.entityForName("ICEFolder", inManagedObjectContext: self.ICEFolderCoreDataStack!.managedObjectContext!)
        
        if let entity = newFolderEntity {
            var newFolderRecord: ICEFolder = ICEFolder(entity: entity, insertIntoManagedObjectContext: self.ICEFolderCoreDataStack!.managedObjectContext!)
            newFolderRecord.name = name
            newFolderRecord.creationDate = NSDate()
        } else {
            println("failed to create a new folder entity")
        }
        
        var saveError: NSError?
        self.ICEFolderCoreDataStack!.managedObjectContext!.save(&saveError)
        
        if let error = saveError {
            println("could not save managed object context: \(error.localizedDescription) & error: \(error)")
        }
    }
    
    //MARK : Divers
    func addFolderCellPressed() {
        println("ICEFoldersCVC - addCellButtonPressed: called")

        let ICEFolderAlertController = UIAlertController(title: "Configure new folder", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        ICEFolderAlertController.addTextFieldWithConfigurationHandler { (textfield: UITextField!) -> Void in
            textfield.placeholder = "Enter the new folder name.."
        }
        let ICEFolderCancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let ICEFolderSaveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            var textfieldArray = ICEFolderAlertController.textFields as! [UITextField]?
            if let array = textfieldArray {
                    if (array[0].text != "") {
                        self.saveNewFolderEntityWithName(array[0].text)
                } else {
                    array[0].placeholder = "no name entered yet!"
                }
            }
        }
        ICEFolderAlertController.addAction(ICEFolderCancelAction)
        ICEFolderAlertController.addAction(ICEFolderSaveAction)
        self.presentViewController(ICEFolderAlertController, animated: true, completion: nil)
    }
    
    func ICESortFolderScansFromSet(aFolderRecord: ICEFolder) -> [ICEScan] {
        var aObjectsSortedArray = NSArray()
        if (aFolderRecord.scans.count != 0) {
            let aFolderScansUnsortedArray = aFolderRecord.scans.allObjects as NSArray
            var dateDescriptor = NSSortDescriptor(key: "date", ascending: true)
            aObjectsSortedArray = aFolderScansUnsortedArray.sortedArrayUsingDescriptors([dateDescriptor])
        } else {
            println("no scan in folder....add dummy data")
        }
        var aICEScansSortedArray: [ICEScan] = aObjectsSortedArray as! [ICEScan]
        return aICEScansSortedArray
    }
    
    func initICEFilesCollectionViewController(aICEFileCVC: ICEFilesCollectionViewController, withFolderRecord aFolderRecord: ICEFolder) {
        println("ICEFolderCVC: initICEFilesCollectionViewController: called")

        aICEFileCVC.ICEFileCoreDataStack = self.ICEFolderCoreDataStack
        aICEFileCVC.aICEFolder = aFolderRecord
        aICEFileCVC.aICEFolderScansSortedArray = self.ICESortFolderScansFromSet(aFolderRecord)
        var aFetchRequest = NSFetchRequest(entityName: "ICEScan")
        var aPredicate = NSPredicate(format: "folder.creationDate == %@", aFolderRecord.creationDate)
        var aDescriptor = NSSortDescriptor(key: "date", ascending: true)
        aFetchRequest.predicate = aPredicate
        aFetchRequest.sortDescriptors = [aDescriptor]
        
        aICEFileCVC.ICEFileFetchedResultsController = NSFetchedResultsController(fetchRequest: aFetchRequest, managedObjectContext: aICEFileCVC.ICEFileCoreDataStack!.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aICEFileCVC.ICEFileFetchedResultsController!.delegate = aICEFileCVC
        
        var fetchError: NSError?
        aICEFileCVC.ICEFileFetchedResultsController!.performFetch(&fetchError)
        
        //get info on fetch:
        println("sections are: \(aICEFileCVC.ICEFileFetchedResultsController!.sections)")
        println("fetched objects are : \(aICEFileCVC.ICEFileFetchedResultsController!.fetchedObjects)")
        
        if let error = fetchError {
            println("could not perform fetch on ICEFile...")
        }

    }
}
