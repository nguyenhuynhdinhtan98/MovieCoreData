//
//  Movie+Extensions.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 09/12/2022.
//

import Foundation
import CoreData

extension Movie: BaseModel {
    static func byID<T>(id: NSManagedObjectID) -> T? where T : NSManagedObjectID {
        return nil
    }
    
    
}
