//
//  Movie+Extensions.swift
//  MovieApp
//
//  Created by Tân Nguyễn on 09/12/2022.
//

import Foundation
import CoreData

extension Movie: BaseModel {
    
    static func byActorName(name: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "actors.name CONTAINS %@", name)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
        
    }
}
