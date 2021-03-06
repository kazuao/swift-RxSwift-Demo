//
//  AppDelegate.swift
//  NewsApp-MVVM
//
//  Created by k-aoki on 2021/07/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        let orangeColor: UIColor = UIColor(red: 255/255, green: 195/255, blue: 18/255, alpha: 1)
        appearance.backgroundColor = orangeColor
        
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white //orangeColor
        ]
        
        appearance.largeTitleTextAttributes = attrs
        appearance.titleTextAttributes = attrs
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

