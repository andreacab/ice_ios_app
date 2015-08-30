//
//  ICEPhysician.swift
//  ICE
//
//  Created by Andrea Cabral on 12.01.15.
//  Copyright (c) 2015 Andrea Cabral. All rights reserved.
//

import Foundation
import CoreData

class ICEPhysician: NSManagedObject {

    //Attributes
    @NSManaged var firstname: String
    @NSManaged var lastname: String
    @NSManaged var type: String
    @NSManaged var streetNumber: NSNumber
    @NSManaged var streetName: String
    @NSManaged var postcode: NSNumber
    @NSManaged var country: String
    
    //Relationships
    @NSManaged var users: NSSet
    @NSManaged var medicalTreatments: NSSet
    @NSManaged var medicines: NSSet

}
