//
//  MainFlowController.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import UIKit
import Swinject

class MainFlowController: FlowController {

    private let assembler = Assembler([ MainFlowAssembly() ])

    private var flowController: FlowController?

    func start() -> UIViewController {
        flowController = assembler.resolver.resolve(FlowController.self)
        return flowController?.start() ?? UIViewController()
    }
}
