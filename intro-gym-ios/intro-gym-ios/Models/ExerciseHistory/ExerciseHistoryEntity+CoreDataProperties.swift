//
//  ExerciseHistoryEntity+CoreDataProperties.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//
//

import Foundation
import CoreData


extension ExerciseHistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseHistoryEntity> {
        return NSFetchRequest<ExerciseHistoryEntity>(entityName: "ExerciseHistoryEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var exerciseId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var reps: Int64
    @NSManaged public var weight: Int64
    @NSManaged public var exercise: ExerciseEntity?

}

extension ExerciseHistoryEntity : Identifiable {

}
