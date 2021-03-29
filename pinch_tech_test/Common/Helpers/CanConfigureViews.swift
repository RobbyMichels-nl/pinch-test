//
//  CanConfigureViews.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import Foundation

protocol CanConfigureViews {
    func configureViews()
    func configureProperties()
    func configureEvents()
}

extension CanConfigureViews {

    func configureViews() {
        configureProperties()
        configureEvents()
    }

    func configureProperties() {}
    func configureEvents() {}
}
