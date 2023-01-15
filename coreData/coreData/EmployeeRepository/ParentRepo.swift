//
//  ParentRepo.swift
//  coreData
//
//  Created by Sawan Rana on 14/01/23.
//

import Foundation

protocol ParentRepo {
    associatedtype T
    
    func create(record: T)
    func readAll() -> [T]?
    func read(by id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(id: UUID) -> Bool
}
