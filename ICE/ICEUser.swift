//
//  ICEUser.swift
//  ICE
//
//  Created by Andrea Cabral on 12.01.15.
//  Copyright (c) 2015 Andrea Cabral. All rights reserved.
//

import Foundation
import CoreData

class ICEUser: NSManagedObject {

    //Attributes
    @NSManaged var firstname: String
    @NSManaged var lastname: String
    @NSManaged var streetNumber: NSNumber
    @NSManaged var streetName: String
    @NSManaged var postcode: NSNumber
    @NSManaged var country: String
    
    //Relationships
    @NSManaged var physicians: NSSet
    @NSManaged var medicines: NSSet
    @NSManaged var medicalTreatments: NSSet
    @NSManaged var folders: NSSet
    @NSManaged var diseases: NSSet
    @NSManaged var bloodType: ICEBloodType
    @NSManaged var allergies: NSSet
    @NSManaged var scans: NSSet
    @NSManaged var father: ICEFamily
    @NSManaged var mother: ICEFamily
    @NSManaged var sons: NSSet

}
