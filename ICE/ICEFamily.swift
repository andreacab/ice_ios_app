//
//  ICEFamily.swift
//  ICE
//
//  Created by Andrea Cabral on 12.01.15.
//  Copyright (c) 2015 Andrea Cabral. All rights reserved.
//

import Foundation
import CoreData

class ICEFamily: NSManagedObject {

    //Attributes
    @NSManaged var name: String
    
    //Relationships
    @NSManaged var father: ICEUser
    @NSManaged var mother: ICEUser
    @NSManaged var sons: NSSet

}
