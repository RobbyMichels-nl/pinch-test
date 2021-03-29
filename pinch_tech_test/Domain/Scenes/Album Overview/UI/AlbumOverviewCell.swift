//
//  AlbumOverviewCell.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import UIKit

class AlbumOverviewCell: UITableViewCell {

    static let identifier = String(describing: AlbumOverviewCell.self)

    @IBOutlet weak var albumNameLabel: UILabel!

    var viewModel: AlbumOverviewCellViewModelProtocol? {
        didSet {
            albumNameLabel.text = viewModel?.albumName
        }
    }

    override func prepareForReuse() {
        albumNameLabel.text = ""
    }
}
