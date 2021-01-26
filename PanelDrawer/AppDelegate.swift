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
        
        let rootExampleSb = UIStoryboard(name: "RootExample", bundle: nil)
        let mainVC = rootExampleSb.instantiateViewController(withIdentifier: "RootExampleController")

        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()

        return true
    }


}

