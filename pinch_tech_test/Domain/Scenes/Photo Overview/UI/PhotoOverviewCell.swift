//
//  PhotoOverviewCell.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//

import UIKit

class PhotoOverviewCell: UITableViewCell {

    static let identifier = String(describing: PhotoOverviewCell.self)

    @IBOutlet weak var albumPhotoLabel: UILabel!
    @IBOutlet weak var albumPhotoImageView: UIImageView!

    var viewModel: PhotoOverviewCellViewModelProtocol? {
        didSet {
            albumPhotoLabel.text = viewModel?.albumPhotoName
            albumPhotoImageView.downloaded(from: viewModel?.albumPhotoUrl)
        }
    }

    override func prepareForReuse() {
        albumPhotoLabel.text = ""
        albumPhotoImageView.image = UIImage()
    }
}
