//
//  AlbumDetailOverviewFlowController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit

class AlbumDetailOverviewFlowController: FlowController {

	func start() -> UIViewController {

		let startVC = AlbumDetailOverviewViewController.make(self, viewModel: nil)

		return startVC
	}
}

// MARK: - AlbumDetailOverviewViewControllerDelegate
extension AlbumDetailOverviewFlowController: AlbumDetailOverviewViewControllerDelegate {

    func albumDetailOverviewViewControllerDidSomething(controller: AlbumDetailOverviewViewController) {

    }
}
