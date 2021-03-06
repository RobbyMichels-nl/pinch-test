//
//  AlbumOverviewViewModel.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//  Copyright (c) 2021 Pinch. All rights reserved.
//

import RxSwift

class AlbumOverviewViewModel: AlbumOverviewViewModelProtocol {

    var items: Observable<[Album]> {
        getAlbums!.execute()
    }

    var getAlbums: GetAlbumsProtocol?

    private let disposeBag = DisposeBag()

    init(getAlbums: GetAlbumsProtocol?) {
        self.getAlbums = getAlbums
    }
}
