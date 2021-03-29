//
//  PhotoOverviewViewModelProtocol.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation
import RxSwift

protocol PhotoOverviewViewModelProtocol: AnyObject {
    var items: Observable<[AlbumPhoto]> { get }
}
