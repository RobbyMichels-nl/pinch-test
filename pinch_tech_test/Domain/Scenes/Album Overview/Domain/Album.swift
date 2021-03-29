//
//  Album.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation
import CoreData

@objc(Album)
class Album: NSManagedObject {

    @NSManaged var id: NSNumber?
    @NSManaged var title: String?
}
