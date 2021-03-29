//
//  PhotoDetailAssembly.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import Swinject

struct PhotoDetailAssembly: Assembly {

    func assemble(container: Container) {
        container.register(PhotoDetailViewModelProtocol.self, factory: {
            (r, albumPhoto) in
            PhotoDetailViewModel(albumPhoto: albumPhoto)
        })
    }
}
