//
//  IdentifierManager.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 12.06.2024.
//

import Foundation

class IdentifierManager {
    
    static let shared = IdentifierManager()
    
    private let workoutKey = "lastWorkoutID"
    private let exerciseKey = "lastExerciseID"
    private let exerciseHistoryKey = "lastExerciseHistoryID"
    private let motivationInfoKey = "lastMotivationInfoID"
    private let exerciseInfoKey = "lastExerciseInfoID"
    private let articleKey = "lastArticleID"
    
    private init() {
        initializeKeyIfNeeded(key: workoutKey)
        initializeKeyIfNeeded(key: exerciseKey)
        initializeKeyIfNeeded(key: exerciseHistoryKey)
        initializeKeyIfNeeded(key: motivationInfoKey)
        initializeKeyIfNeeded(key: exerciseInfoKey)
        initializeKeyIfNeeded(key: articleKey)
    }
    
    private func initializeKeyIfNeeded(key: String) {
        if UserDefaults.standard.value(forKey: key) == nil {
            UserDefaults.standard.set(0, forKey: key)
        }
    }
    
    func getNextWorkoutID() -> Int64 {
        return getNextID(forKey: workoutKey)
    }
    
    func getNextExerciseID() -> Int64 {
        return getNextID(forKey: exerciseKey)
    }
    
    func getNextExerciseHistoryID() -> Int64 {
        return getNextID(forKey: exerciseHistoryKey)
    }
    
    func getNextMotivationInfoID() -> Int64 {
        return getNextID(forKey: motivationInfoKey)
    }
    
    func getNextExerciseInfoID() -> Int64 {
        return getNextID(forKey: exerciseInfoKey)
    }
    
    func getNextArticleID() -> Int64 {
        return getNextID(forKey: articleKey)
    }
    
    private func getNextID(forKey key: String) -> Int64 {
        let currentID = UserDefaults.standard.integer(forKey: key)
        let nextID = currentID + 1
        UserDefaults.standard.set(nextID, forKey: key)
        return Int64(nextID)
    }
}

