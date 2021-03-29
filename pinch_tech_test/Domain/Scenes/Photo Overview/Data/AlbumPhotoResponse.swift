//
//  AlbumPhotoResponse.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation

struct AlbumPhotoResponse: Codable {

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
