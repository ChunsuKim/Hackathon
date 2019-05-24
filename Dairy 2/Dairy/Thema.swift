//
//  Thema.swift
//  Dairy
//
//  Created by 차수연 on 22/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import Foundation
import UIKit

struct Thema { //초기값

  
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

}

//var themaDatas: [Thema] = [
//  Thema(dataLabel: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), mainLabel: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), writeButton: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), cardView: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), tabBarTint: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), tabBarBarTint: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
//  Thema(dataLabel: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), mainLabel: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), writeButton: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), cardView: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), tabBarTint: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), tabBarBarTint: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
//  Thema(dataLabel: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), mainLabel: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), writeButton: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), cardView: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), tabBarTint: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), tabBarBarTint: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
//  Thema(dataLabel: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), mainLabel: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), writeButton: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), cardView: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), tabBarTint: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), tabBarBarTint: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
//]


