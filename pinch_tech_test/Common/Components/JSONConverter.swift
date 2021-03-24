//
//  JSONConverter.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import Foundation

class JSONConverter<T: Codable>: Converter<T> {

    private enum Errors: String, Error {
        case noData
    }

    override func convert(valueToConvert: AnyObject?) throws -> T {
        guard let data = valueToConvert as? Data else { throw Errors.noData }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
