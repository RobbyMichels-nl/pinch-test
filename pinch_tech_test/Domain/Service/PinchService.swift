//
//  PinchService.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 23/03/2021.
//

import Foundation

class PinchService: Service {

    init(endpoint: String) {
        super.init(baseURL: "http://testapi.pinch.nl:3000/", endPoint: endpoint)
    }
}
