//
//  AppDelegate.swift
//  ULiftProject
//
//  Created by ELSAGA-MACOS on 9/8/20.
//  Copyright © 2020 ELSAGA-MACOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
                   self.window?.backgroundColor = UIColor.white
                   
                   let welcome = CalendarVC.init()
                   self.window?.rootViewController = welcome
                   self.window?.makeKey()
                   self.window?.isHidden = false
        return true
    }

}

