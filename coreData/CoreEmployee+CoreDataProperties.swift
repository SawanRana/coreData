//
//  CoreEmployee+CoreDataProperties.swift
//  coreData
//
//  Created by Sawan Rana on 15/01/23.
//
//

import Foundation
import CoreData


extension CoreEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreEmployee> {
        return NSFetchRequest<CoreEmployee>(entityName: "CoreEmployee")
    }

    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var toDrivingLicense: CoreDrivingLicense?

}

extension CoreEmployee : Identifiable {

}
