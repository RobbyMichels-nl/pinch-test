//
//  AlbumPhotoRepositoryProtocol.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import RxSwift

protocol AlbumPhotoRepositoryProtocol {
    func get() -> Observable<[AlbumPhoto]>
}
