//
//  GetAlbums.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation
import RxSwift

class GetAlbums: GetAlbumsProtocol {

    let albumRepository: AlbumRepositoryProtocol

    init(albumRepository: AlbumRepositoryProtocol?) {
        self.albumRepository = albumRepository!
    }

    func execute() -> Observable<[Album]> {
        albumRepository.get()
    }
}
