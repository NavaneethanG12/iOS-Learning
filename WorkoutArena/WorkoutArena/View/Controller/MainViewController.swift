//
//  MainViewController.swift
//  WorkoutArena
//
//  Created by navaneeth-pt4855 on 08/06/22.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = ViewController()
        vc1.tabBarItem = UITabBarItem(title: "Home",
                                      image: UIImage(systemName: "house"),
                                                       selectedImage: UIImage(systemName: "house"))
                        
        let nav1 = UINavigationController(rootViewController: vc1)
        
        let vc2 = DogViewController()
        vc2.tabBarItem = UITabBarItem(title: "tabBar_Dog", image: UIImage(named: "tabBar_dog")?.resizeImage(targetSize: CGSize(width: 20, height: 20)) , selectedImage: UIImage(named: "tabBar_dog_selected")?.resizeImage(targetSize: CGSize(width: 25, height: 25)))
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let vc3 = DogViewController()
        vc2.tabBarItem = UITabBarItem(title: "tabBar_Dog", image: UIImage(named: "tabBar_dog")?.resizeImage(targetSize: CGSize(width: 20, height: 20)) , selectedImage: UIImage(named: "tabBar_dog_selected")?.resizeImage(targetSize: CGSize(width: 25, height: 25)))
        let nav3 = UINavigationController(rootViewController: vc3)
        
        viewControllers = [nav1,nav2,nav3]
        setIOS15TabBar()
    }
    
    
}
