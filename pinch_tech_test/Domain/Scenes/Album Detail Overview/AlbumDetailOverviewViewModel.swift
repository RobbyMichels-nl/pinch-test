//
//  AlbumDetailOverviewViewModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 24/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import Foundation
import RxSwift

protocol AlbumDetailOverviewViewModelProtocol: AnyObject {
    var items: Observable<[AlbumPhoto]> { get }
	// NOOP
}

class AlbumDetailOverviewViewModel: AlbumDetailOverviewViewModelProtocol {

    var items: Observable<[AlbumPhoto]> {
        getAlbumPhotos!.execute()
    }

    private let getAlbumPhotos: GetAlbumPhotosProtocol?

    init(getAlbumPhotos: GetAlbumPhotosProtocol?) {
        self.getAlbumPhotos = getAlbumPhotos
    }
}
