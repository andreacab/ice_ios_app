//
//  ICEScan.swift
//  ICE
//
//  Created by Andrea Cabral on 12.01.15.
//  Copyright (c) 2015 Andrea Cabral. All rights reserved.
//

import Foundation
import CoreData

class ICEScan: NSManagedObject {

    //Attributes
    @NSManaged var date: NSDate
    @NSManaged var name: String
    @NSManaged var scanData: NSData
    
    //Relationships
    @NSManaged var folder: ICEFolder
    @NSManaged var user: ICEUser

}
