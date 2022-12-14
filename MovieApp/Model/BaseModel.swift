//
//  BaseModel.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 07/12/2022.
//

import Foundation
import CoreData

protocol BaseModel: NSManagedObject {
    func save() throws
    func delete() throws
    static func getAll<T: NSManagedObject>() -> [T]
    static func byID<T: NSManagedObject>(id: NSManagedObjectID) -> T?
}

extension BaseModel {
    
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    func save() {
        do {
            try Self.viewContext.save()
        } catch {
            Self.viewContext.rollback()
        }
        
        
    }
    
    func delete() {
        do {
            Self.viewContext.delete(self)
            try save()
        } catch {
            Self.viewContext.rollback()
        }
       
    }
    
   static func getAll<T>() -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func byID<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        do {
            return try viewContext.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
        
    }
    
}
