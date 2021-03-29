//
//  AlbumOverviewViewController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import UIKit
import Swinject
import RxSwift

protocol AlbumOverviewViewControllerDelegate: class {
    func albumOverviewViewControllerDidSomething(controller: UIViewController?, album: Album)
}

class AlbumOverviewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate: AlbumOverviewViewControllerDelegate?

    private var viewModel: AlbumOverviewViewModelProtocol!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        bindTableView()
        configureViews()
    }
}

private extension AlbumOverviewViewController {

    func bindTableView() {
        tableView.register(
            UINib(
                nibName: AlbumOverviewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: AlbumOverviewCell.identifier
        )

        viewModel.items.bind(to: tableView.rx.items(
            cellIdentifier: AlbumOverviewCell.identifier,
            cellType: AlbumOverviewCell.self
        )) {
            row, item, cell in
            cell.viewModel = AlbumOverviewCellViewModel(albumName: item.title!)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Album.self).subscribe(onNext: {
            [weak self] album in
            guard let self = self else { return }
            self.delegate?.albumOverviewViewControllerDidSomething(controller: self, album: album)
        }).disposed(by: disposeBag)
    }
}

extension AlbumOverviewViewController {

    static func make(_ delegate: AlbumOverviewViewControllerDelegate? = nil, viewModel: AlbumOverviewViewModelProtocol?) -> AlbumOverviewViewController {
		let storyboard = UIStoryboard(name: "AlbumOverview", bundle: nil)
        let factoryVC = storyboard.instantiateViewController(withIdentifier: "AlbumOverviewViewController") as! AlbumOverviewViewController
        factoryVC.delegate = delegate
        factoryVC.viewModel = viewModel

		return factoryVC
	}
}

extension AlbumOverviewViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension AlbumOverviewViewController: CanConfigureViews {

    func configureProperties() {
        view.backgroundColor = .white

        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: -1, left: 0, bottom: 0, right: 0)
    }
}
