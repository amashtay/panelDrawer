//
//  AppDelegate.swift
//  PanelDrawer
//
//  Created by Александр Тонхоноев on 19.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "PanelDrawer", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! PanelDrawerController

        let rootExampleSb = UIStoryboard(name: "RootExample", bundle: nil)
        let mainVC = rootExampleSb.instantiateViewController(withIdentifier: "ExampleController")
        controller.mainController = mainVC

        let tableExampleSb = UIStoryboard(name: "TableExample", bundle: nil)
        let tableVC = tableExampleSb.instantiateInitialViewController()
        controller.panelDrawerController = tableVC

        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        return true
    }


}

