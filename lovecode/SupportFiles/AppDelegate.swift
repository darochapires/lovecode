//
//  AppDelegate.swift
//  lovecode
//
//  Created by Pedro Filipe da Rocha Pires on 19/09/2018.
//  Copyright © 2018 inbloom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var user: User?
    var profilesList: [PersonalityProfile]?
    var testAnswers: [Int] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.04, green:0.13, blue:0.15, alpha:1.0)
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}
