//
//  AppDelegate.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        copyDatabaseIfNeeded()
        return true
    }
    
    private func copyDatabaseIfNeeded() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsURL.appendingPathComponent("Model.sqlite")
        
        if !fileManager.fileExists(atPath: destinationURL.path) {
            if let sourceURL = Bundle.main.url(forResource: "Model", withExtension: "sqlite") {
                do {
                    try fileManager.copyItem(at: sourceURL, to: destinationURL)
                    print("Database copied to \(destinationURL.path)")
                } catch {
                    print("Error copying database: \(error.localizedDescription)")
                    // Handle the error (show alert to user, retry, etc.)
                }
            } else {
                print("Source database file not found.")
                // Handle the error (show alert to user, retry, etc.)
            }
        } else {
            print("Database file already exists at \(destinationURL.path)")
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {  }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let storeURL = documentsURL.appendingPathComponent("Model.sqlite")

            let description = NSPersistentStoreDescription(url: storeURL)
            container.persistentStoreDescriptions = [description]
            
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

