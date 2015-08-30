//
//  ICEMedicine.swift
//  ICE
//
//  Created by Andrea Cabral on 12.01.15.
//  Copyright (c) 2015 Andrea Cabral. All rights reserved.
//

import Foundation
import CoreData

class ICEMedicine: NSManagedObject {

    //Attributes
    @NSManaged var name: String
    @NSManaged var company: String
    @NSManaged var frequency: NSNumber
    
    //Relationships
    @NSManaged var users: NSSet
    @NSManaged var diseases: NSSet
    @NSManaged var medicalTreatments: NSSet
    @NSManaged var physicians: NSSet

}
