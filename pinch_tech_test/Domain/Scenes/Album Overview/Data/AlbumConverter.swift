//
//  AlbumConverter.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 25/03/2021.
//

import Foundation

class AlbumConverter: Converter<[AlbumResponse]> {

    override func convert(valueToConvert: AnyObject?) throws -> [AlbumResponse] {
        let converter = JSONConverter<[AlbumResponse]>()
        let response = try converter.convert(valueToConvert: valueToConvert)
        return response
    }
}
