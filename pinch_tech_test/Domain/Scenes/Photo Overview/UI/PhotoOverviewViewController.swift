//
//  PhotoOverviewViewController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit
import RxSwift

protocol PhotoOverviewViewControllerDelegate: class {
    func albumDetailOverviewViewControllerDidSomething(controller: UIViewController?, albumPhoto: AlbumPhoto)
}

class PhotoOverviewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: PhotoOverviewViewControllerDelegate?

    private var viewModel: PhotoOverviewViewModelProtocol!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        bindTableView()
        configureViews()
    }
}

private extension PhotoOverviewViewController {

    func bindTableView() {
        tableView.register(
            UINib(
                nibName: PhotoOverviewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: PhotoOverviewCell.identifier
        )

        viewModel.items.bind(to: tableView.rx.items(
            cellIdentifier: PhotoOverviewCell.identifier,
            cellType: PhotoOverviewCell.self
        )) {
            row, item, cell in
            cell.viewModel = PhotoOverviewCellViewModel(albumPhoto: item)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(AlbumPhoto.self).subscribe(onNext: {
            [weak self] albumPhoto in
            guard let self = self else { return }
            self.delegate?.albumDetailOverviewViewControllerDidSomething(controller: self, albumPhoto: albumPhoto)
        }).disposed(by: disposeBag)
    }
}

extension PhotoOverviewViewController {

    static func make(
        _ delegate: PhotoOverviewViewControllerDelegate? = nil,
        viewModel: PhotoOverviewViewModelProtocol? = nil
    ) -> PhotoOverviewViewController {
		let storyboard = UIStoryboard(name: "PhotoOverview", bundle: nil)
		let factoryVC = storyboard.instantiateViewController(withIdentifier: "PhotoOverviewViewController") as! PhotoOverviewViewController
		factoryVC.viewModel = viewModel
        factoryVC.delegate = delegate

		return factoryVC
	}
}

extension PhotoOverviewViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        166
    }
}

extension PhotoOverviewViewController: CanConfigureViews {

    func configureProperties() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
}
