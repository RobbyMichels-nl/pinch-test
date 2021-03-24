//
//  TableView.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import UIKit


class TableView: UITableView {

    var viewModel: TableViewViewModel! {
        didSet {
            register(viewModel.register().0, forCellReuseIdentifier: viewModel.register().1)
            configureProperties()

            if viewModel.onDidLoadData == nil {
                viewModel.onDidLoadData = {
                    [weak self] in
                    self?.reloadData()
                }
            }

            viewModel.reloadData(tableView: self)
        }
    }
}

extension TableView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier(indexPath: indexPath)) ?? viewModel.cell(indexPath: indexPath)

        return cell
    }
}

extension TableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        viewModel?.onDidSelectRow?(indexPath)
    }
}

extension TableView: CanConfigureViews {

    func configureProperties() {
        separatorStyle = .none
        dataSource = self
        delegate = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = viewModel?.estimatedRowHeight ?? 0

        contentInset = .init(top: -1, left: 0, bottom: 0, right: 0)
    }

    func configureViewEvents() {
        viewModel?.onDidLoadData = {
            [weak self] in
            self?.reloadData()
        }
    }
}
