//
//  CoreDataStack.swift
//  ICE
//
//  Created by Andrea Cabral on 14.11.14.
//  Copyright (c) 2014 Andrea Cabral. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.andreacabral.ICE" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("ICE", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let storeURL: NSURL = self.applicationStoresDirectory()!.URLByAppendingPathComponent("Store.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        var options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error: &error) == nil {
            let fm = NSFileManager.defaultManager()
            if (fm.fileExistsAtPath(storeURL.path!)){
                let corruptURL = self.applicationIncompatibleStoresDirectory()!.URLByAppendingPathComponent(self.nameForIncompatibleStore())
                var errorMoveStore: NSError?
                fm.moveItemAtURL(storeURL, toURL: corruptURL, error:&errorMoveStore)
                if let error = errorMoveStore {
                    println("could not move corrupted store")
                }
            }
            let title = "Warning"
            let applicationName: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDIsplayName") as! String
            let message = String(format: "A serious application error occurred while %@ tried to access your data. Please contact support for help", applicationName)
            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            coordinator = nil
//            // Report any error we got.
//            let dict = NSMutableDictionary()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason
//            dict[NSUnderlyingErrorKey] = error
//            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//            // Replace this with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog("Unresolved error \(error), \(error!.userInfo)")
            //abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    
    func applicationStoresDirectory() -> NSURL? {
        let fm = NSFileManager.defaultManager()
        let applicationApplicationSupportDirectory: NSURL? = fm.URLsForDirectory(NSSearchPathDirectory.ApplicationSupportDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as? NSURL
        let url = applicationApplicationSupportDirectory?.URLByAppendingPathComponent("Stores")
        
        if let directoryURL = url {
            if(!(fm.fileExistsAtPath(directoryURL.path!))) {
                var createDirectoryError: NSError?
                fm.createDirectoryAtURL(directoryURL, withIntermediateDirectories: true, attributes: nil, error:&createDirectoryError)
                if let error = createDirectoryError {
                    println("unable to create directory for data stores...")
                    return nil
                }
            }
        } else {
            println("could not get a URL directroy for data stores")
            return nil
        }
        return url
    }
    
    func applicationIncompatibleStoresDirectory() -> NSURL? {
        let fm = NSFileManager.defaultManager()
        let url = self.applicationStoresDirectory()?.URLByAppendingPathComponent("Incompatible")

        if let directoryURL = url {
            if(!(fm.fileExistsAtPath(directoryURL.path!))) {
                var createDirectoryError: NSError?
                fm.createDirectoryAtURL(directoryURL, withIntermediateDirectories: true, attributes: nil, error:&createDirectoryError)
                if let error = createDirectoryError {
                    println("unable to create directory for incompatible data stores...")
                    return nil
                }
            }
        } else {
            println("could not get a URL directroy for incompatible data stores")
            return nil
        }
        return url
    }

    func nameForIncompatibleStore() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.formatterBehavior = NSDateFormatterBehavior.Behavior10_4
        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        
        return String(format: "%@.sqlite", dateFormatter.stringFromDate(NSDate()))
    }
}
