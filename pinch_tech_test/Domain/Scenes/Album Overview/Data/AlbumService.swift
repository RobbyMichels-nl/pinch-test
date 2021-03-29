//
//  AlbumService.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation
import RxSwift

class AlbumService: PinchService, AlbumServiceProtocol {

    init() {
        super.init(endpoint: "albums")
    }

    func performRequest() -> Observable<[AlbumResponse]> {
        super.performRequest(converter: AlbumConverter())
    }
}
