//
//  CanMapToDomainModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation

protocol CanMapToDomainModel {
    associatedtype DomainModel
    func toDomainModel() throws -> DomainModel
}