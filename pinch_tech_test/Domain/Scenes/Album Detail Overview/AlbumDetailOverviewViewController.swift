//
//  AlbumDetailOverviewViewController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit
import RxSwift

protocol AlbumDetailOverviewViewControllerDelegate: AnyObject {
	func albumDetailOverviewViewControllerDidSomething(controller: AlbumDetailOverviewViewController)
}

class AlbumDetailOverviewViewController: UIViewController {

	weak var delegate: AlbumDetailOverviewViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: AlbumDetailOverviewViewModelProtocol!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        bindTableView()
        configureViews()
    }
}

private extension AlbumDetailOverviewViewController {

    func bindTableView() {
        tableView.register(UINib(nibName: AlbumOverviewCell.identifier, bundle: nil), forCellReuseIdentifier: AlbumOverviewCell.identifier)

        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: AlbumOverviewCell.identifier, cellType: AlbumOverviewCell.self)) {
            row, item, cell in
            cell.viewModel = .init(albumName: item.title)
        }.disposed(by: disposeBag)

//        tableView.rx.modelSelected(Album.self).subscribe(onNext: {
//            [weak self] album in
//            guard let self = self else { return }
//            self.delegate?.albumOverviewViewControllerDidSomething(controller: self, album: album)
//        }).disposed(by: disposeBag)
    }
}

// MARK: - Factory
extension AlbumDetailOverviewViewController {

	static func make(_ delegate: AlbumDetailOverviewViewControllerDelegate? = nil, viewModel: AlbumDetailOverviewViewModelProtocol? = nil) -> AlbumDetailOverviewViewController {

		let storyboard = UIStoryboard(name: "AlbumDetailOverview", bundle: nil)
		let factoryVC = storyboard.instantiateViewController(withIdentifier: "AlbumDetailOverviewViewController") as! AlbumDetailOverviewViewController
		factoryVC.delegate = delegate
		factoryVC.viewModel = viewModel

		return factoryVC
	}
}

extension AlbumDetailOverviewViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension AlbumDetailOverviewViewController: CanConfigureViews {

    func configureProperties() {
        view.backgroundColor = .white

        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: -1, left: 0, bottom: 0, right: 0)
    }
}
