//
//  UIViewController+.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 31/05/22.
//

import Foundation
import UIKit


extension UIViewController{
    
    func setIOS15Navigation(){
        if #available(iOS 15, *){
            let app = UINavigationBarAppearance()
            app.backgroundColor = Colors.navBarColor
            app.titleTextAttributes = [ .foregroundColor: Colors.navTintColor]
            app.largeTitleTextAttributes = [ .foregroundColor: Colors.navTintColor]
            self.navigationController?.navigationBar.barTintColor = Colors.navTintColor
            self.navigationController?.navigationBar.standardAppearance = app
            self.navigationController?.navigationBar.scrollEdgeAppearance = app
        }else{
            navigationController?.navigationBar.backgroundColor = Colors.navBarColor
            navigationController?.navigationBar.barTintColor = Colors.navTintColor
            self.navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: Colors.navTintColor, .backgroundColor: Colors.navTintColor]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.navTintColor]
        }
        
//        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    
}

extension UITabBarController{
    func setIOS15TabBar(){
        if #available(iOS 15, *){
            let app = UITabBarAppearance()
            app.backgroundColor = Colors.navBarColor
            self.tabBar.barTintColor = Colors.navTintColor
            self.tabBar.standardAppearance = app
            self.tabBar.scrollEdgeAppearance = app
        }else{
            tabBar.backgroundColor = Colors.navBarColor
            tabBar.barTintColor = Colors.navTintColor
           
        }
    }
}
