//
//  BaseModel.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 07/12/2022.
//

import Foundation
import CoreData

protocol BaseModel: NSManagedObject {
    func save()
    func delete()
    static func byID<T: NSManagedObjectID>(id: NSManagedObjectID) -> T
    static func getAll<T: NSManagedObject>() -> [T]
}

extension BaseModel {
    func save() {
        CoreDataManager.shared.save()
    }
    
    func delete() {
        CoreDataManager.shared.viewContext.delete(self)
        save()
    }
    
    static func getAll<T>() -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        do {
            return try CoreDataManager.shared.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        do {
            return try CoreDataManager.shared.viewContext.existingObject(with: id) as? T
        } catch {
            return nil
        }
    }
    
}
