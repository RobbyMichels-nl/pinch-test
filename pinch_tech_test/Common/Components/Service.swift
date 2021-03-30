//
//  Service.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import Foundation

import RxSwift
import RxCocoa

class Service {

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    var httpMethod: HTTPMethod = .get
    var baseURL: String
    var endPoint: String

    private var url: URL {
        URL(string: baseURL + endPoint)!
    }

    init(baseURL: String, endPoint: String) {
        self.baseURL = baseURL
        self.endPoint = endPoint
    }

    func performRequest<T>(converter: Converter<T>) -> Observable<T> {
        var request = try? URLRequest(url: url)
        request?.httpMethod = httpMethod.rawValue
        request?.addValue("application/json", forHTTPHeaderField: "Accept")

        return URLSession.shared.rx.data(request: request!)
            .map {
                data in
                try converter.convert(valueToConvert: data as AnyObject)
            }
            .observe(on: MainScheduler.asyncInstance)
    }
}

class Converter<T> {

    enum Errors: String, Error {
        case failedToConvert = "Failed to convert"
    }

    func convert(valueToConvert: AnyObject?) throws -> T {
        if let convertedValue = valueToConvert as? T {
            return convertedValue
        } else {
            throw Errors.failedToConvert
        }
    }
}
