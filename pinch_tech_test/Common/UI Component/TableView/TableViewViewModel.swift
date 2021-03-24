//
//  TableViewViewModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import UIKit
import RxSwift

protocol TableViewViewModel {

    var onDidSelectRow: ((IndexPath) -> ())? { get set }
    var onDidLoadData: (() -> ())? { get set }

    var numberOfSections: Int { get }
    var numberOfRowsInSection: Int { get }
    var estimatedRowHeight: CGFloat { get }

    func register() -> (UINib, String)

    func reloadData(tableView: TableView)
    func numberOfRows(section: Int) -> Int
    func reuseIdentifier(indexPath: IndexPath) -> String
    func cell(indexPath: IndexPath) -> UITableViewCell
    func cellClass(indexPath: IndexPath) -> UITableViewCell.Type
}

extension TableViewViewModel {

    func cell(indexPath: IndexPath) -> UITableViewCell {
        let cellClass: UITableViewCell.Type = self.cellClass(indexPath: indexPath)
        return cellClass.init(style: .default, reuseIdentifier: reuseIdentifier(indexPath: indexPath))
    }

    func reuseIdentifier(indexPath: IndexPath) -> String {
        String(describing: cellClass(indexPath: indexPath))
    }
}
