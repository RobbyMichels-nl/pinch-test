//
//  PhotoOverviewFlowController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit
import Swinject

class PhotoOverviewFlowController: FlowController {

    private let assembler = Assembler([
        AlbumPhotoOverviewAssembly(),
        PhotoDetailFlowAssembly()
    ])

    private let album: Album
    private var flowController: FlowController?

    init(album: Album) {
        self.album = album
    }

	func start() -> UIViewController {
        let startVC = PhotoOverviewViewController.make(
            self,
            viewModel: assembler.resolver.resolve(PhotoOverviewViewModelProtocol.self, argument: album)
        )

		return startVC
	}
}

extension PhotoOverviewFlowController: PhotoOverviewViewControllerDelegate {

    func albumDetailOverviewViewControllerDidSomething(controller: UIViewController?, albumPhoto: AlbumPhoto) {
        flowController = assembler.resolver.resolve(FlowController.self, argument: albumPhoto)
        controller?.navigationController?.pushViewController(flowController?.start() ?? UIViewController(), animated: true)
    }
}
