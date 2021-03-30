//
//  EntityRepository.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import CoreData

class EntityRepository<T: NSManagedObject> {

    private let managedContext: NSManagedObjectContext

    init(managedContext: NSManagedObjectContext = CoreDataPersistenceStore.shared.context) {
        self.managedContext = managedContext
    }

    func createEntity() -> T? {
        if let entity =  NSEntityDescription.entity(forEntityName: String(describing: T.self), in: managedContext) {
            return NSManagedObject(entity: entity, insertInto: managedContext) as? T
        } else {
            return nil
        }
    }

    func get(key: String, value: String) -> [T] {
        let predicate = NSPredicate(format: "\(key) = %@", value)
        return get(with: predicate)
    }

    func getAll() -> [T] {
        let request = fetchRequest()

        do {
            return try managedContext.fetch(request)
        } catch {
            return []
        }
    }

    func removeAll() {
        getAll().forEach {
            managedContext.delete($0)
        }
    }
}

private extension EntityRepository {

    func get(with predicate: NSPredicate) -> [T] {
        let request = fetchRequest().predicate(predicate: predicate)

        do {
            return try managedContext.fetch(request)
        } catch {
            return []
        }
    }

    func fetchRequest() -> NSFetchRequest<T> {
        NSFetchRequest<T>(entityName: String(describing: T.self))
    }
}
