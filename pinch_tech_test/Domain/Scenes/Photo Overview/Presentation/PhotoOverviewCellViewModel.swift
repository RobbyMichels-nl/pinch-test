//
//  PhotoOverviewCellViewModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import Foundation

struct PhotoOverviewCellViewModel: PhotoOverviewCellViewModelProtocol {

    let albumPhotoName: String
    let albumPhotoUrl: URL?

    init(albumPhoto: AlbumPhoto) {
        self.albumPhotoName = albumPhoto.title
        if let thumbnailUrlString = albumPhoto.thumbnailUrlString {
            albumPhotoUrl = URL(string: thumbnailUrlString)
        } else {
            albumPhotoUrl = nil
        }
    }
}
