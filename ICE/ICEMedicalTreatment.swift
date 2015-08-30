//
//  ICEMedicalTreatment.swift
//  ICE
//
//  Created by Andrea Cabral on 12.01.15.
//  Copyright (c) 2015 Andrea Cabral. All rights reserved.
//

import Foundation
import CoreData

class ICEMedicalTreatment: NSManagedObject {

    //Attributes
    @NSManaged var name: String
    
    //Relationships
    @NSManaged var users: NSSet
    @NSManaged var diseases: NSSet
    @NSManaged var medicines: NSSet
    @NSManaged var physicians: NSSet

}
