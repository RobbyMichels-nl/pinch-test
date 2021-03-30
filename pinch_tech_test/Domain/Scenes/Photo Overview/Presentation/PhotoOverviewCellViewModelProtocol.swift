//
//  PhotoOverviewCellViewModelProtocol.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import Foundation

protocol PhotoOverviewCellViewModelProtocol {
    var albumPhotoName: String { get }
    var albumPhotoUrl: URL? { get }
}
