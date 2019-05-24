//
//  Thema.swift
//  DayByDay
//
//  Created by 차수연 on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import Foundation
import UIKit

struct Thema { //초기값
  
  static var num = 3
  static var dataLabel = #colorLiteral(red: 0.1746840775, green: 0.4984993339, blue: 0.7566666007, alpha: 1)
  static var mainLabel = #colorLiteral(red: 0.2571163177, green: 0.7560217977, blue: 0.9694374204, alpha: 1)
  static var writeButton = #colorLiteral(red: 0.2398266494, green: 0.6760053039, blue: 0.9694671035, alpha: 1)
  static var cardView = #colorLiteral(red: 0.460631609, green: 0.8378008604, blue: 0.9999235272, alpha: 1)
  static var tabBarTint = #colorLiteral(red: 0.1039802805, green: 0.2768733501, blue: 0.3995706141, alpha: 1)
  static var tabBarBarTint = #colorLiteral(red: 0.460631609, green: 0.8378008604, blue: 0.9999235272, alpha: 1)
  
  static func Thema1(){
    dataLabel = UIColor.darkGray
    mainLabel = UIColor.white
    writeButton = UIColor.white
    cardView = UIColor.white
    tabBarTint = UIColor.white
    tabBarBarTint = UIColor.black
  }
  
  static func Thema2(){
    dataLabel = UIColor.orange
    mainLabel = UIColor.red
    writeButton = UIColor.blue
    cardView = UIColor.yellow
    tabBarTint = UIColor.white
    tabBarBarTint = UIColor.black
  }
  
  static func Thema3(){
    dataLabel = UIColor.green
    mainLabel = UIColor.green
    writeButton = UIColor.green
    cardView = UIColor.green
    tabBarTint = UIColor.green
    tabBarBarTint = UIColor.green
  }
  
}
