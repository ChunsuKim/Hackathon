//
//  CustomTabBarViewController.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    let tabBarItemQuantity = 3
    let backgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        backgroundView.backgroundColor = .white
        backgroundView.alpha = 0.4
        backgroundView.isHidden = true
        
        tabBar.isTranslucent = false
        tabBar.tintColor = Theme.tabBarBarTint
        tabBar.barTintColor = Theme.tabBarTint
        tabBar.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], for: .normal)
        
        view.addSubview(backgroundView)
        
        let firstTab = ViewController()
        let firstTabBarItem = UITabBarItem(title: "기록", image: UIImage(named: "pen"), selectedImage: UIImage(named: "pen"))
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = ListViewController()
        let secondTabBarItem = UITabBarItem(title: "열람", image: UIImage(named: "note"), selectedImage: UIImage(named: "note"))
        secondTab.tabBarItem = secondTabBarItem
        
        let thirdTab = SettingViewController()
        let thridTabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting"))
        thirdTab.tabBarItem = thridTabBarItem
        
        self.viewControllers = [
            firstTab,
            UINavigationController(rootViewController: secondTab),
            thirdTab]
    }
    
    
    
    
}
