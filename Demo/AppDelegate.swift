//
//  AppDelegate.swift
//  ULiftProject
//
//  Created by ELSAGA-MACOS on 9/8/20.
//  Copyright © 2020 ELSAGA-MACOS. All rights reserved.
//

import UIKit
//asdfasfasdfasdf
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        let welcome = CalendarViewController.init()
        let nav = UINavigationController(rootViewController: welcome)
        window?.rootViewController = nav

        window?.makeKeyAndVisible()
        
        return true
    }
}
