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
    var parameters: Data?
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

protocol GetAlbumsProtocol {
    func execute() -> Observable<[Album]>
}

class GetAlbums: GetAlbumsProtocol {

    let albumService: AlbumServiceProtocol

    init(albumService: AlbumServiceProtocol?) {
        self.albumService = albumService!
    }

    func execute() -> Observable<[Album]> {
        albumService.performRequest().compactMap { innerValue in innerValue.compactMap { try? $0.toDomainModel() }}
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

struct AlbumResponse: Codable {

    let userId: Int
    let id: Int
    let title: String
}

extension AlbumResponse: CanMapToDomainModel {

    func toDomainModel() throws -> Album {
        .init(title: title)
    }
}

struct Album {

    let title: String
}

protocol AlbumServiceProtocol {
    func performRequest() -> Observable<[AlbumResponse]>
}

class AlbumService: PinchService, AlbumServiceProtocol {

    init() {
        super.init(endpoint: "albums")
    }

    func performRequest() -> Observable<[AlbumResponse]> {
        super.performRequest(converter: AlbumConverter())
    }
}

class AlbumConverter: Converter<[AlbumResponse]> {

    override func convert(valueToConvert: AnyObject?) throws -> [AlbumResponse] {
        let converter = JSONConverter<[AlbumResponse]>()
        let response = try converter.convert(valueToConvert: valueToConvert)
        return response
    }
}

protocol CanMapToDomainModel {
    associatedtype DomainModel
    func toDomainModel() throws -> DomainModel
}

protocol AlbumPhotoServiceProtocol {
    func performRequest() -> Observable<[AlbumPhotoResponse]>
}

class AlbumPhotoService: PinchService, AlbumPhotoServiceProtocol {

    init(albumId: Int) {
        super.init(endpoint: "photos?albumId=\(albumId)")
    }

    func performRequest() -> Observable<[AlbumPhotoResponse]> {
        super.performRequest(converter: AlbumPhotoConverter())
    }
}

struct AlbumPhotoResponse: Codable {

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension AlbumPhotoResponse: CanMapToDomainModel {

    func toDomainModel() throws -> AlbumPhoto {
        .init(
            albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
    }
}

struct AlbumPhoto {

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

class AlbumPhotoConverter: Converter<[AlbumPhotoResponse]> {

    override func convert(valueToConvert: AnyObject?) throws -> [AlbumPhotoResponse] {
        let converter = JSONConverter<[AlbumPhotoResponse]>()
        let response = try converter.convert(valueToConvert: valueToConvert)
        return response
    }
}

protocol GetAlbumPhotosProtocol {
    func execute() -> Observable<[AlbumPhoto]>
}

struct GetAlbumPhotos: GetAlbumPhotosProtocol {

    let albumPhotoService: AlbumPhotoServiceProtocol

    init(albumPhotoService: AlbumPhotoServiceProtocol) {
        self.albumPhotoService = albumPhotoService
    }

    func execute() -> Observable<[AlbumPhoto]> {
        albumPhotoService.performRequest().compactMap { innerValue in innerValue.compactMap { albumPhoto in try? albumPhoto.toDomainModel() }}
    }
}
