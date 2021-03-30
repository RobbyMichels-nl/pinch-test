//
//  PhotoDetailViewController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 26/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoDetailLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    private var viewModel: PhotoDetailViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
}

extension PhotoDetailViewController {

	static func make(viewModel: PhotoDetailViewModelProtocol?) -> PhotoDetailViewController {
		let storyboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
		let factoryVC = storyboard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as! PhotoDetailViewController
		factoryVC.viewModel = viewModel

		return factoryVC
	}
}

extension PhotoDetailViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        photoImageView
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = 1.0
    }
}

extension PhotoDetailViewController: CanConfigureViews {

    func configureProperties() {
        view.backgroundColor = .white

        scrollView.delegate = self
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.flashScrollIndicators()
        scrollView.clipsToBounds = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0

        photoImageView.downloaded(from: viewModel.albumPhotoUrl)
        photoImageView.clipsToBounds = false

        photoDetailLabel.text = viewModel.albumPhotoName
    }
}
