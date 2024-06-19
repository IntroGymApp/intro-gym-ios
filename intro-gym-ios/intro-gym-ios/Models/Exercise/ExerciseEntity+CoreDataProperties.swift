//
//  ExerciseEntity+CoreDataProperties.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//
//

import Foundation
import CoreData


extension ExerciseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseEntity> {
        return NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
    }

    @NSManaged public var exerciseInfoId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var note: String?
    @NSManaged public var reps: Int64
    @NSManaged public var sets: Int64
    @NSManaged public var weight: Int64
    @NSManaged public var workoutId: Int64
    @NSManaged public var exerciseHistory: NSSet?
    @NSManaged public var workout: WorkoutEntity

}

// MARK: Generated accessors for exerciseHistory
extension ExerciseEntity {

    @objc(addExerciseHistoryObject:)
    @NSManaged public func addToExerciseHistory(_ value: ExerciseHistoryEntity)

    @objc(removeExerciseHistoryObject:)
    @NSManaged public func removeFromExerciseHistory(_ value: ExerciseHistoryEntity)

    @objc(addExerciseHistory:)
    @NSManaged public func addToExerciseHistory(_ values: NSSet)

    @objc(removeExerciseHistory:)
    @NSManaged public func removeFromExerciseHistory(_ values: NSSet)

}

extension ExerciseEntity : Identifiable {

}
