//
//  AlbumOverviewCell.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import UIKit

struct AlbumOverviewCellViewModel: AlbumOverviewCellViewModelProtocol {

    let albumName: String
}

protocol AlbumOverviewCellViewModelProtocol {
    var albumName: String { get }
}

class AlbumOverviewCell: UITableViewCell {

    static let identifier = String(describing: AlbumOverviewCell.self)

    @IBOutlet weak var albumNameLabel: UILabel!

    var viewModel: AlbumOverviewCellViewModel? {
        didSet {
            albumNameLabel.text = viewModel?.albumName
        }
    }

    override func prepareForReuse() {
        albumNameLabel.text = ""
    }
}
