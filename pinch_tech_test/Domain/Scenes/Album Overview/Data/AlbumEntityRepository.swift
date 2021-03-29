//
//  AlbumEntityRepository.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import CoreData

class AlbumEntityRepository: EntityRepository<Album> {

    private let managedContext: NSManagedObjectContext

    override init(managedContext: NSManagedObjectContext = CoreDataPersistenceStore.shared.context) {
        self.managedContext = managedContext
        super.init(managedContext: managedContext)
    }

    func save(responseEntity: AlbumResponse) {
        if let entity = createEntity() {
            entity.id = NSNumber(value: responseEntity.id)
            entity.title = responseEntity.title

            do{
                try managedContext.save()
            } catch {
                debugPrint("Couldnt save entity: Album")
            }
        }
    }
}
