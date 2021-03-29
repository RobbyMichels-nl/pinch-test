//
//  AlbumPhoto.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation
import CoreData

@objc(AlbumPhoto)
class AlbumPhoto: NSManagedObject {

    @NSManaged var albumId: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var title: String
    @NSManaged var urlString: String?
    @NSManaged var thumbnailUrlString: String?
}
