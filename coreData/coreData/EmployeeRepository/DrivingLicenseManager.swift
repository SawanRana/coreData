//
//  DrivingLicenseManager.swift
//  coreData
//
//  Created by Sawan Rana on 14/01/23.
//

import Foundation

class DrivingLicenseManager {
    
    private var dlRepository: DLDataRepo = DLDataRepo()
    
    func create(record: DL) {
        dlRepository.create(record: record)
    }
    
    func readAll() -> [DL]? {
        return dlRepository.readAll()
    }
    
    func read(by id: UUID) -> DL? {
        return dlRepository.read(by: id)
    }
    
    func update(record: DL) -> Bool {
        dlRepository.update(record: record)
    }
    
    func delete(id: UUID) -> Bool {
        dlRepository.delete(id: id)
    }
}
