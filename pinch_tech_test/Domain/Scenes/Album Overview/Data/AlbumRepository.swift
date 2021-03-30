//
//  AlbumRepository.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import RxSwift

class AlbumRepository: AlbumRepositoryProtocol {

    let albumService: AlbumServiceProtocol
    let albumEntityRepository: AlbumEntityRepository

    init(
        albumService: AlbumServiceProtocol?,
        albumEntityRepository: AlbumEntityRepository?
    ) {
        self.albumService = albumService!
        self.albumEntityRepository = albumEntityRepository!
    }

    func get() -> Observable<[Album]> {
        let albums = getModelsInternal()
        if !albums.isEmpty {
            return Observable.of(albums)
        } else {
            return getModelsExternally()
        }
    }
}

private extension AlbumRepository {

    func getModelsInternal() -> [Album] {
        albumEntityRepository.getAll()
    }

    func getModelsExternally() -> Observable<[Album]> {
        return albumService.performRequest().map {
            [weak self] innerValues -> [Album] in
            guard let self = self else { return [] }
            innerValues.forEach {
                albumResponse in
                self.albumEntityRepository.save(responseEntity: albumResponse)
            }

            return self.getModelsInternal()
        }
    }
}
