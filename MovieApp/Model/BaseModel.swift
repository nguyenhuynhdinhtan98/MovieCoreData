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
    func byID<T: NSManagedObjectID>(id: NSManagedObjectID) -> T?
    func getAll<T: NSManagedObject>() -> [T]
}

extension BaseModel {
    
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    func save() {
        CoreDataManager.shared.save()
    }
    
    func delete() {
        Self.viewContext.delete(self)
        save()
    }
    
   static func getAll<T>() -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        do {
            return try viewContext.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }
    
}
