//
//  NSFetchRequest+predicate.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import CoreData

extension NSFetchRequest {

    @objc func predicate(predicate: NSPredicate) -> Self {
        self.predicate = predicate
        return self
    }
}
