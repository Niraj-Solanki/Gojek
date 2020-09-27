//
//  Repository+CoreDataProperties.swift
//  Gojek
//
//  Created by Neeraj Solanki on 27/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var author: String?
    @NSManaged public var avatar: String?
    @NSManaged public var forks: Int64
    @NSManaged public var name: String?
    @NSManaged public var repoDescription: String?
    @NSManaged public var stars: Int64
    @NSManaged public var url: String?
    @NSManaged public var timestamp: Double
}
