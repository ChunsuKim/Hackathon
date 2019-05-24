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
  
  var temp: Int = 0 {
    willSet {
      changeColor()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    changeColor()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    changeColor()
  }
  
  
  
  func changeColor() {
    tabBar.tintColor = Thema.tabBarTint
    tabBar.barTintColor = Thema.tabBarBarTint
  }
  
  
  
  func configure() {
    backgroundView.backgroundColor = .white
    backgroundView.alpha = 0.4
    backgroundView.isHidden = true
    
    tabBar.isTranslucent = false
    
    tabBar.unselectedItemTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], for: .normal)
    
    view.addSubview(backgroundView)
    
    let firstTab = ViewController()
    let firstTabBarItem = UITabBarItem(title: "기록", image: UIImage(named: "pen"), selectedImage: UIImage(named: "pen"))
    firstTab.tabBarItem = firstTabBarItem
    firstTab.view.backgroundColor = .white
    
    
    let secondTab = ListViewController()
    let secondTabBarItem = UITabBarItem(title: "열람", image: UIImage(named: "note"), selectedImage: UIImage(named: "note"))
    secondTab.tabBarItem = secondTabBarItem
    secondTab.view.backgroundColor = .white
    
    let thirdTab = SettingViewController()
    let thridTabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting"))
    thirdTab.tabBarItem = thridTabBarItem
    //        thirdTab.view.backgroundColor = .white
    
    self.viewControllers = [firstTab, secondTab, thirdTab]
  }
  
  
  
  
}
