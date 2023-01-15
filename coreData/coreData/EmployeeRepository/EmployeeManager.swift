//
//  EmployeeManager.swift
//  coreData
//
//  Created by Sawan Rana on 13/01/23.
//

import Foundation

struct EmployeeManager {
    
    private let employeeDataRepo = EmployeeDataRepo()
    
    func create(employee: Employee) {
        employeeDataRepo.create(record: employee)
    }
    
    func readAllEmployee() -> [Employee]? {
        return employeeDataRepo.readAll()
    }
    
    func readEmployee(by id: UUID) -> Employee? {
        return employeeDataRepo.read(by: id)
    }
    
    func update(employee: Employee) -> Bool {
        return employeeDataRepo.update(record: employee)
    }
    
    func delete(id: UUID) -> Bool {
        return employeeDataRepo.delete(id: id)
    }

}
