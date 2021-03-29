//
//  AlbumOverviewAssembly.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import Swinject

struct AlbumOverviewAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AlbumServiceProtocol.self, factory: { _ in AlbumService() })
        container.register(AlbumEntityRepository.self, factory: { _ in AlbumEntityRepository() })

        container.register(AlbumRepositoryProtocol.self, factory: {
            _ in
            AlbumRepository(
                albumService: container.resolve(AlbumServiceProtocol.self),
                albumEntityRepository:  container.resolve(AlbumEntityRepository.self)
            )
        })

        container.register(GetAlbumsProtocol.self, factory: {
            _ in
            GetAlbums(
                albumRepository: container.resolve(AlbumRepositoryProtocol.self)
            )
        })

        container.register(AlbumOverviewViewModelProtocol.self, factory: {
            _ in AlbumOverviewViewModel(
                getAlbums: container.resolve(GetAlbumsProtocol.self)
            )
        })
    }
}
