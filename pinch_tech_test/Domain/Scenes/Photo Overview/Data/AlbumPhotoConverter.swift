//
//  AlbumPhotoConverter.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation

class AlbumPhotoConverter: Converter<[AlbumPhotoResponse]> {

    override func convert(valueToConvert: AnyObject?) throws -> [AlbumPhotoResponse] {
        let converter = JSONConverter<[AlbumPhotoResponse]>()
        let response = try converter.convert(valueToConvert: valueToConvert)
        return response
    }
}
