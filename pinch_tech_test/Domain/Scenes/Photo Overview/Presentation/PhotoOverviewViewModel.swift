//
//  PhotoOverviewViewModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import Foundation
import RxSwift

class PhotoOverviewViewModel: PhotoOverviewViewModelProtocol {

    var items: Observable<[AlbumPhoto]> {
        getAlbumPhotos!.execute()
    }

    private let getAlbumPhotos: GetAlbumPhotosProtocol?

    init(getAlbumPhotos: GetAlbumPhotosProtocol?) {
        self.getAlbumPhotos = getAlbumPhotos
    }
}
