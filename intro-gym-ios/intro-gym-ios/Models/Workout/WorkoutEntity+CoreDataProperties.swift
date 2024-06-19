//
//  WorkoutEntity+CoreDataProperties.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//
//

import Foundation
import CoreData


extension WorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEntity> {
        return NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var descr: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var exercise: NSSet?

}

// MARK: Generated accessors for exercise
extension WorkoutEntity {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: ExerciseEntity)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: ExerciseEntity)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

extension WorkoutEntity : Identifiable {

}
