//
//  CustomTapBarController.swift
//  TravelDiary
//
//  Created by Chunsu Kim on 26/06/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class CustomTapBarController: UITabBarController {
    
    let tabBarItemQuantity = 4
    
    let thirdTab = WriteViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    func configureTabBar() {
        
        tabBar.isTranslucent = false
        tabBar.tintColor = #colorLiteral(red: 0.009850479662, green: 0.29078269, blue: 0.5762767196, alpha: 1)
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.2)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1996214092, green: 0.5940744281, blue: 0.8613047004, alpha: 1)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], for: .normal)
        
        let firstTab = MainViewController()
        let firstTabBarItem = UITabBarItem(title: "Main", image: UIImage(named: "mainTap"), selectedImage: UIImage(named: "mainTap"))
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = MyLogViewController()
        let secondTabBarItem = UITabBarItem(title: "My Log", image: UIImage(named: "mylogTap"), selectedImage: UIImage(named: "mylogTap"))
        secondTab.tabBarItem = secondTabBarItem
        
        
        let thridTabBarItem = UITabBarItem(title: "Write", image: UIImage(named: "writeTap"), selectedImage: UIImage(named: "writeTap"))
        thirdTab.tabBarItem = thridTabBarItem
        
        let forthTab = ForecastViewController()
        let forthTapBarItem = UITabBarItem(title: "Forecast", image: UIImage(named: "forecast"), selectedImage: UIImage(named: "forecast"))
        forthTab.tabBarItem = forthTapBarItem
        
        self.viewControllers = [firstTab, secondTab, thirdTab, forthTab]
    }
}
