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
    @IBOutlet weak var containerView: UIView!

    var viewModel: AlbumOverviewCellViewModelProtocol? {
        didSet {
            albumNameLabel.text = viewModel?.albumName

            configureViews()
        }
    }

    override func prepareForReuse() {
        albumNameLabel.text = ""
    }
}

extension AlbumOverviewCell: CanConfigureViews {

    func configureProperties() {
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .white

        backgroundColor = UIColor.white.withAlphaComponent(0)
        selectionStyle = .none
    }
}
