//
//  EmployeeRepo.swift
//  coreData
//
//  Created by Sawan Rana on 13/01/23.
//

import Foundation
import CoreData

struct Employee {
    var id: UUID
    var name: String
    var age: Int16
    var email: String
    var dl: DL?
}

protocol EmployeeRepo: ParentRepo {
   
}

struct EmployeeDataRepo: EmployeeRepo {
    typealias T = Employee
    
    func readAll() -> [Employee]? {
        let coreEmployees = PersistentStorage.shared.fetchManagedObject(mangedObj: CoreEmployee.self)
        var employees = [Employee]()
        coreEmployees.forEach { employee in
            employees.append(employee.makeEmployee())
        }
        return employees
    }
    
    func read(by id: UUID) -> Employee? {
        if let coreEmployee = getEmployee(by: id) {
            return coreEmployee.makeEmployee()
        }
        return nil
    }
    
    func create(record: Employee) {
        let coreEmployee = CoreEmployee(context: PersistentStorage.shared.context)
        coreEmployee.name = record.name
        coreEmployee.age = record.age
        coreEmployee.email = record.email
        coreEmployee.id = record.id
        
        if record.dl != nil {
            let coreDL = CoreDrivingLicense(context: PersistentStorage.shared.context)
            coreDL.id = record.dl?.id
            coreDL.placeOfIssue = record.dl?.placeOdfIssue
            coreDL.drivingLicenseId = record.dl?.drivingLicenseId
            
            coreEmployee.toDrivingLicense = coreDL
        }
        PersistentStorage.shared.saveContext()
    }
    
    func update(record: Employee) -> Bool {
        if let coreEmployee = getEmployee(by: record.id) {
            coreEmployee.name = record.name
            coreEmployee.email = record.email
            coreEmployee.age = record.age
            
            coreEmployee.toDrivingLicense?.drivingLicenseId = record.dl?.drivingLicenseId
            coreEmployee.toDrivingLicense?.placeOfIssue = record.dl?.placeOdfIssue
            return true
        }
        return false
    }
    
    func delete(id: UUID) -> Bool {
        if let coreEmployee = getEmployee(by: id) {
            PersistentStorage.shared.context.delete(coreEmployee)
            PersistentStorage.shared.saveContext()
            return true
        }
        return false
    }
    
    private func getEmployee(by id: UUID) -> CoreEmployee? {
        let fetchRequest = NSFetchRequest<CoreEmployee>(entityName: "CoreEmployee")
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
