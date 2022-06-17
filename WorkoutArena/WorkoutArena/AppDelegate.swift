//
//  AppDelegate.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 31/05/22.
//

import UIKit
import Intents

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = MainViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = vc
        
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: .logoutSuccess, object: nil)
        
        requestSiriAuthorization()
        
        return true
    }
    
    @objc func logoutUser(){
        window?.rootViewController = MainViewController()
    }
    
    private func requestSiriAuthorization(){
        INPreferences.requestSiriAuthorization { status in
          if status == .authorized {
            print("Hey, Siri!")
          } else {
            print("Nay, Siri!")
          }
        }
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

