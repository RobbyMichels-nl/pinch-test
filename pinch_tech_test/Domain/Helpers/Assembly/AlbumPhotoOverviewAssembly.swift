//
//  AlbumPhotoOverviewAssembly.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import Swinject

struct AlbumPhotoOverviewAssembly: Assembly {

    func assemble(container: Container) {
        container.register(
            AlbumPhotoServiceProtocol.self,
            factory: {
                (r, album: Album) in
                AlbumPhotoService(albumId: album.id!)
            })

        container.register(AlbumPhotoEntityRepository.self, factory: {
            _ in
            AlbumPhotoEntityRepository()
        })

        container.register(
            AlbumPhotoRepositoryProtocol.self,
            factory: {
                (r, album: Album) in
                AlbumPhotoRepository(
                    service: container.resolve(AlbumPhotoServiceProtocol.self, argument: album),
                    repository: container.resolve(AlbumPhotoEntityRepository.self),
                    album: album
                )
            }
        )

        container.register(
            GetAlbumPhotosProtocol.self,
            factory: {
                (r, album: Album) in
                GetAlbumPhotos(repository: container.resolve(AlbumPhotoRepositoryProtocol.self, argument: album))
            }
        )

        container.register(
            PhotoOverviewViewModelProtocol.self,
            factory: {
                (r, album: Album) in
                PhotoOverviewViewModel(getAlbumPhotos: container.resolve(GetAlbumPhotosProtocol.self, argument: album))
            }
        )
    }
}
