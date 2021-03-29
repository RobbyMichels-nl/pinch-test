//
//  AlbumPhotoEntityRepository.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import CoreData

class AlbumPhotoEntityRepository: EntityRepository<AlbumPhoto> {

    private let managedContext: NSManagedObjectContext

    override init(managedContext: NSManagedObjectContext = CoreDataPersistenceStore.shared.context) {
        self.managedContext = managedContext
        super.init(managedContext: managedContext)
    }

    func save(responseEntity: AlbumPhotoResponse) {
        if let entity = createEntity() {
            entity.id = NSNumber(value: responseEntity.id)
            entity.albumId = NSNumber(value: responseEntity.albumId)
            entity.title = responseEntity.title
            entity.urlString = responseEntity.url
            entity.thumbnailUrlString = responseEntity.thumbnailUrl

            do{
                try managedContext.save()
            } catch {
                debugPrint("Couldnt save entity: Album")
            }
        }
    }
}
