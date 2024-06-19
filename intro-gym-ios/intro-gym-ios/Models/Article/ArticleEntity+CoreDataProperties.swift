//
//  ArticleEntity+CoreDataProperties.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var descr: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: String?
    @NSManaged public var name: String?

}

extension ArticleEntity : Identifiable {

}
