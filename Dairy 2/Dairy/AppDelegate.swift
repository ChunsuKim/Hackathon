//
//  AppDelegate.swift
//  Dairy
//
//  Created by Chunsu Kim on 20/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var memolist = [MemoData]() // 메모 데이터를 저장할 배열
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window? = UIWindow(frame: UIScreen.main.bounds)
    
    window?.backgroundColor = .white
    window?.rootViewController = CustomTabBarViewController()
    window?.makeKeyAndVisible()
    
    UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    
    return true
  }
  
  
  
}

