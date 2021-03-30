//
//  PhotoDetailViewModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 26/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import Foundation

struct PhotoDetailViewModel: PhotoDetailViewModelProtocol {

    let albumPhotoName: String
    let albumPhotoUrl: URL?

    init(albumPhoto: AlbumPhoto) {
        self.albumPhotoName = albumPhoto.title
        if let urlString = albumPhoto.urlString {
            albumPhotoUrl = URL(string: urlString)
        } else {
            albumPhotoUrl = nil
        }
    }
}
