//
//  CoreDataManager.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 03.06.2024.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
}

// MARK: - CRUD for Workout
extension CoreDataManager {
    
    func getAllWorkoutsByDate(date: Date) {}
    
    func getAllWorkouts() -> [WorkoutEntity]? {
        let fetchRequest: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
        
        do {
            let workouts = try context.fetch(fetchRequest)
            return workouts
        } catch {
            print("Failed to fetch workouts: \(error)")
            return nil
        }
    }
    
    func addWorkoutAtDay(workout: WorkoutEntity, date: Date) {
        let newWorkout = WorkoutEntity(context: context)
        newWorkout.id = IdentifierManager.shared.getNextWorkoutID()
        newWorkout.name = workout.name
        newWorkout.descr = workout.descr
        newWorkout.date = date
        
        if let exercises = workout.exercise as? Set<ExerciseEntity> {
            for exercise in exercises {
                let newExercise = ExerciseEntity(context: context)
                newExercise.id = IdentifierManager.shared.getNextExerciseID()
                newExercise.name = exercise.name
                newExercise.sets = exercise.sets
                newExercise.reps = exercise.reps
                newExercise.weight = exercise.weight
                newExercise.exerciseInfoId = exercise.exerciseInfoId
                newExercise.note = exercise.note

                newWorkout.addToExercise(newExercise)
            }
        }
        
        appDelegate.saveContext()
    }
    
    func deleteWorkout(workout: WorkoutEntity) {
        if let exercises = workout.exercise?.allObjects as? [ExerciseEntity] {
            for exercise in exercises {
                deleteExercise(exercise: exercise)
            }
        }
        context.delete(workout)
        appDelegate.saveContext()
    }
    
    func getWorkoutById(id: Int64) -> WorkoutEntity? {
        let fetchRequest: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        do {
            let workouts = try context.fetch(fetchRequest)
            return workouts.first
        } catch {
            print("Failed to fetch workout: \(error)")
            return nil
        }
    }
    
    func createWorkout(name: String, descr: String, exercises: [ExerciseEntity]?) {
        let workout = WorkoutEntity(context: context)
        workout.id = IdentifierManager.shared.getNextWorkoutID()
        workout.name = name
        workout.descr = descr
        
        if let exercises = exercises {
            workout.exercise = NSSet(array: exercises)
        }
        
        appDelegate.saveContext()
    }
    
    func getLastCreatedWorkout() -> Int {
        let lastId = getAllWorkouts()?.last?.id ?? -1
        
        return Int(lastId)
    }
    
    func updateWorkoutById(id: Int64, newName: String?, newDescr: String?, newExercises: [ExerciseEntity]?) {
        if let workout = getWorkoutById(id: id) {
            workout.name = newName ?? workout.name
            workout.descr = newDescr
            
            if let newExercises = newExercises {
                workout.exercise = NSSet(array: newExercises)
            }
            
            appDelegate.saveContext()
        }
    }
    
}

// MARK: - CRUD for Exercise
extension CoreDataManager {
    
    func getAllExersicesByWorkoutId(workoutId: Int64) -> [ExerciseEntity]? {
        let fetchRequest: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "workoutId == %lld", workoutId)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Failed to fetch exercise by id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func createExercise(workoutId: Int64, name: String, exerciseInfoId: Int64, sets: Int64 = 0, reps: Int64 = 0, weight: Int64 = 0, note: String?) {
        let exercise = ExerciseEntity(context: context)
        exercise.id = IdentifierManager.shared.getNextExerciseID()
        exercise.name = name
        exercise.workoutId = workoutId
        exercise.exerciseInfoId = exerciseInfoId
        exercise.sets = sets
        exercise.reps = reps
        exercise.weight = weight
        exercise.note = note
        
        if let workout = getWorkoutById(id: workoutId) {
            workout.addToExercise(exercise)
        }
        
        appDelegate.saveContext()
    }
    
    func deleteExercise(exercise: ExerciseEntity) {
        if let exerciseHistory = exercise.exerciseHistory?.allObjects as? [ExerciseHistoryEntity] {
            for exerciseSet in exerciseHistory {
                context.delete(exerciseSet)
            }
        }
        context.delete(exercise)
        appDelegate.saveContext()
    }
    
    func getExerciseById(id: Int64) -> ExerciseEntity? {
        let fetchRequest: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        do {
            let exercise = try context.fetch(fetchRequest)
            return exercise.first
        } catch {
            print("Failed to fetch workout: \(error)")
            return nil
        }
    }
    
    func updateExerciseById(id: Int64, newSets: Int64?, newReps: Int64?, newWeight: Int64?, newNote: String?) {
        if let exercise = getExerciseById(id: id) {
            exercise.sets = newSets ?? exercise.sets
            exercise.reps = newReps ?? exercise.reps
            exercise.weight = newWeight ?? exercise.weight
            exercise.note = newNote
        }
        
        appDelegate.saveContext()
    }
    
}

// MARK: - CRUD for ExerciseInfo
extension CoreDataManager {
    
    func getExerciseInfoById(id: Int64) -> ExerciseInfoEntity? {
        let fetchRequest: NSFetchRequest<ExerciseInfoEntity> = ExerciseInfoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed to fetch exercise info by id: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllExercisesInfoByGroup(group: String) -> [ExerciseInfoEntity] {
        let fetchRequest: NSFetchRequest<ExerciseInfoEntity> = ExerciseInfoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "group == %@", group)
        
        do {
            let exercises = try context.fetch(fetchRequest)
            return exercises
        } catch {
            print("Failed to fetch exercises info: \(error)")
            return []
        }
    }
    
}

// MARK: - CRUD for ExerciseHistory
extension CoreDataManager {
    
    func getExerciseHistoryById(id: Int64) -> [ExerciseHistoryEntity]? {
        let fetchRequest: NSFetchRequest<ExerciseHistoryEntity> = ExerciseHistoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        
        do {
            let exerciseHistory = try context.fetch(fetchRequest)
            return exerciseHistory
        } catch {
            print("Failed to fetch exerciseHistory: \(error)")
            return nil
        }
    }
    
    func getAllExerciseHistoryByExerciseId(exerciseId: Int64) -> [ExerciseHistoryEntity]? {
        let fetchRequest: NSFetchRequest<ExerciseHistoryEntity> = ExerciseHistoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "exerciseId == %lld", exerciseId)
        
        do {
            let exerciseHistory = try context.fetch(fetchRequest)
            return exerciseHistory
        } catch {
            print("Failed to fetch exerciseHistory: \(error)")
            return nil
        }
    }
    
    func addExerciseHistoryByExerciseId(exerciseId: Int64, reps: Int64, weight: Int64) {
        let exerciseHistory = ExerciseHistoryEntity(context: context)
        exerciseHistory.id = IdentifierManager.shared.getNextExerciseHistoryID()
        exerciseHistory.reps = reps
        exerciseHistory.weight = weight
        
        if let exercise = getExerciseById(id: exerciseId) {
            exerciseHistory.exerciseId = exercise.id
            exercise.addToExerciseHistory(exerciseHistory)
        }
        
        appDelegate.saveContext()
    }
    
}
