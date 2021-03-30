//
//  CoreDataPersistenceStore.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import CoreData

class CoreDataPersistenceStore {

    static let shared = CoreDataPersistenceStore()

    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    private var managedObjectModel: NSManagedObjectModel?
    private let modelName = "Model"

    init() {
        setUpManageObjectModel()
        context.persistentStoreCoordinator = configurePersistentStoreCoordinator()
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint("An error occurred while saving: \(error)")
            }
        }
    }
}

private extension CoreDataPersistenceStore {

    func setUpManageObjectModel() {
        if let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") {
            managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        }
    }

    func configurePersistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
        guard let managedObjectModel = managedObjectModel else { return nil }

        let fileManager = FileManager.default
        let storeName = "\(modelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        do {
            try persistentStoreCoordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: persistentStoreURL,
                options: nil
            )

            return persistentStoreCoordinator

        } catch {
            fatalError("Unable to Load Persistent Store")
        }
    }
}
