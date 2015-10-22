//
//  Films+CoreDataProperties.swift
//  MyFilms
//
//  Created by Diane Christy on 10/20/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Films {

    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var genre: String?
    @NSManaged var length: String?
    @NSManaged var info: String?

}
