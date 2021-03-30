//
//  AlbumPhotoService.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation
import RxSwift

class AlbumPhotoService: PinchService, AlbumPhotoServiceProtocol {

    init(albumId: NSNumber) {
        super.init(endpoint: "photos?albumId=\(albumId)")
    }

    func performRequest() -> Observable<[AlbumPhotoResponse]> {
        super.performRequest(converter: AlbumPhotoConverter())
    }
}
