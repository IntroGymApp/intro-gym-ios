//
//  ExerciseInfoEntity+CoreDataProperties.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//
//

import Foundation
import CoreData


extension ExerciseInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseInfoEntity> {
        return NSFetchRequest<ExerciseInfoEntity>(entityName: "ExerciseInfoEntity")
    }

    @NSManaged public var advices: String?
    @NSManaged public var descr: String?
    @NSManaged public var execution: String?
    @NSManaged public var group: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: String?
    @NSManaged public var name: String
    @NSManaged public var preparation: String?

}

extension ExerciseInfoEntity : Identifiable {

}
