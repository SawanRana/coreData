//
//  DrivingLicenseRepo.swift
//  coreData
//
//  Created by Sawan Rana on 14/01/23.
//

import Foundation
import CoreData

struct DL {
    var id: UUID
    var drivingLicenseId: String
    var placeOdfIssue: String
    var name: String?
}

protocol DLRepo: ParentRepo {
}

struct DLDataRepo: DLRepo {
    typealias T = DL
    
    func create(record: DL) {
        let coreDL = CoreDrivingLicense(context: PersistentStorage.shared.context)
        coreDL.id = record.id
        coreDL.placeOfIssue = record.placeOdfIssue
        coreDL.drivingLicenseId = record.drivingLicenseId
        
        PersistentStorage.shared.saveContext()
    }
    
    func readAll() -> [DL]? {
        let coreDLs = PersistentStorage.shared.fetchManagedObject(mangedObj: CoreDrivingLicense.self)
        var DLs = [DL]()
        coreDLs.forEach { dl in
            DLs.append(dl.makeDL())
        }
        return DLs
    }
    
    func read(by id: UUID) -> DL? {
        if let dl = getDL(by: id) {
            return dl.makeDL()
        }
        return nil
    }
    
    func update(record: DL) -> Bool {
        if let coreDL = getDL(by: record.id) {
            coreDL.placeOfIssue = record.placeOdfIssue
            coreDL.drivingLicenseId = record.drivingLicenseId
            return true
        }
        return false
    }
    
    func delete(id: UUID) -> Bool {
        if let dl = getDL(by: id) {
            PersistentStorage.shared.context.delete(dl)
            PersistentStorage.shared.saveContext()
            return true
        }
        return false
    }
    
    private func getDL(by id: UUID) -> CoreDrivingLicense? {
        let fetchRequest = NSFetchRequest<CoreDrivingLicense>(entityName: "CoreDrivingLicense")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            return result
        } catch let error {
            debugPrint("Error \(error.localizedDescription)")
        }
        return nil
        
    }
    
}
