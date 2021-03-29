//
//  AppDelegate.swift
//  pinch_tech_test
//
//  Created by Robby Michels on 22/03/2021.
//

import UIKit
import CoreData
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let mainFlowController = MainFlowController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = CoreDataPersistenceStore.shared

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = mainFlowController.start()

        return true
    }
}
