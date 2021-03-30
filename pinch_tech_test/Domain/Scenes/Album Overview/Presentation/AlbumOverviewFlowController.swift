//
//  AlbumOverviewFlowController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit
import Swinject

class AlbumOverviewFlowController: FlowController {

    private let navigationController = UINavigationController()

    private let assembler = Assembler(
        [
            AlbumOverviewAssembly(),
            AlbumPhotoFlowAssembly()
        ]
    )

    private var flowController: FlowController?

	func start() -> UIViewController {
        let viewModel = assembler.resolver.resolve(AlbumOverviewViewModelProtocol.self)
        let startVC = AlbumOverviewViewController.make(self, viewModel: viewModel)

        navigationController.viewControllers = [startVC]

		return navigationController
	}
}

extension AlbumOverviewFlowController: AlbumOverviewViewControllerDelegate {

    func albumOverviewViewControllerDidSomething(controller: UIViewController?, album: Album) {
        flowController = assembler.resolver.resolve(FlowController.self, argument: album)
        controller?.navigationController?.pushViewController(flowController?.start() ?? UIViewController(), animated: true)
    }
}
