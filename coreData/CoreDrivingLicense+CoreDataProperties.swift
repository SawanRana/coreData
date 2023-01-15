//
//  CoreDrivingLicense+CoreDataProperties.swift
//  coreData
//
//  Created by Sawan Rana on 15/01/23.
//
//

import Foundation
import CoreData


extension CoreDrivingLicense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDrivingLicense> {
        return NSFetchRequest<CoreDrivingLicense>(entityName: "CoreDrivingLicense")
    }

    @NSManaged public var drivingLicenseId: String?
    @NSManaged public var id: UUID?
    @NSManaged public var placeOfIssue: String?
    @NSManaged public var toEmployee: CoreEmployee?

}

extension CoreDrivingLicense : Identifiable {

}
