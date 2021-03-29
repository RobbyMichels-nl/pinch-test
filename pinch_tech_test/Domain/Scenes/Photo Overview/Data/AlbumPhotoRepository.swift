//
//  AlbumPhotoRepository.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import RxSwift

class AlbumPhotoRepository: AlbumPhotoRepositoryProtocol {

    let service: AlbumPhotoServiceProtocol
    let repository: AlbumPhotoEntityRepository

    private let album: Album

    init(
        service: AlbumPhotoServiceProtocol?,
        repository: AlbumPhotoEntityRepository?,
        album: Album
    ) {
        self.service = service!
        self.repository = repository!
        self.album = album
    }

    func get() -> Observable<[AlbumPhoto]> {
        let albumPhotos = getModelsInternal()
        if !albumPhotos.isEmpty {
            return Observable.of(albumPhotos)
        } else {
            return getModelsExternally()
        }
    }
}

private extension AlbumPhotoRepository {

    func getModelsInternal() -> [AlbumPhoto] {
        repository.get(key: "albumId", value: album.id!.stringValue)
    }

    func getModelsExternally() -> Observable<[AlbumPhoto]> {
        return service.performRequest().map {
            [weak self] innerValues -> [AlbumPhoto] in
            guard let self = self else { return [] }
            innerValues.forEach {
                albumResponse in
                self.repository.save(responseEntity: albumResponse)
            }

            return self.getModelsInternal()
        }
    }
}
