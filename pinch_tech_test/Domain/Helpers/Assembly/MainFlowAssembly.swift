//
//  MainFlowAssembly.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 29/03/2021.
//

import Swinject

struct MainFlowAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FlowController.self, factory: { _ in AlbumOverviewFlowController() })
    }
}
