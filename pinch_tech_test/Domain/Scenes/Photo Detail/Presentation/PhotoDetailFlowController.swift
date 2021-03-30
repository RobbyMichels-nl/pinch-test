//
//  PhotoDetailFlowController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 26/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit
import Swinject

class PhotoDetailFlowController: FlowController {

    private let assembler = Assembler([PhotoDetailAssembly()])

    private let albumPhoto: AlbumPhoto

    init(albumPhoto: AlbumPhoto) {
        self.albumPhoto = albumPhoto
    }

	func start() -> UIViewController {
        let startVC = PhotoDetailViewController.make(
            viewModel: assembler.resolver.resolve(PhotoDetailViewModelProtocol.self, argument: albumPhoto)
        )

		return startVC
	}
}
