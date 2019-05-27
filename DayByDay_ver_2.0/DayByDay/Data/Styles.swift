//
//  Styles.swift
//  DayByDay
//
//  Created by Chunsu Kim on 23/05/2019.
//  Copyright © 2019 Chunsu Kim. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    static var tabBarTint = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
    static var tabBarBarTint = #colorLiteral(red: 0.1071653441, green: 0.2755028009, blue: 0.3986083865, alpha: 1)
    static var tabBarUnselectedTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static var writeButton = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
    static var dateLabel = #colorLiteral(red: 0.176399827, green: 0.4986500144, blue: 0.757831037, alpha: 1)
    static var mainLabel = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
    static var cardView = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
    static var cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static var buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    static public func defaultTheme() {
        self.tabBarTint = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.1071653441, green: 0.2755028009, blue: 0.3986083865, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.writeButton = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0.176399827, green: 0.4986500144, blue: 0.757831037, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
        self.cardView = #colorLiteral(red: 0.4621340632, green: 0.8370614648, blue: 1, alpha: 1)
        self.cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static public func darkBlueTheme() {
        self.tabBarTint = #colorLiteral(red: 0.2531840801, green: 0.220611304, blue: 0.8930563927, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.writeButton = #colorLiteral(red: 0.2531840801, green: 0.220611304, blue: 0.8930563927, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0.2683359385, green: 0.3678353727, blue: 0.7584179044, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.2531840801, green: 0.220611304, blue: 0.8930563927, alpha: 1)
        self.cardView = #colorLiteral(red: 0.2531840801, green: 0.220611304, blue: 0.8930563927, alpha: 1)
        self.cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static public func pinkTheme() {
        self.tabBarTint = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.writeButton = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.cardView = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static public func violetTheme() {
        self.tabBarTint = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.writeButton = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.cardView = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static public func greenTheme() {
        self.tabBarTint = #colorLiteral(red: 0.3542211652, green: 0.7981814742, blue: 0.4792824984, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.writeButton = #colorLiteral(red: 0.3542211652, green: 0.7981814742, blue: 0.4792824984, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.3542211652, green: 0.7981814742, blue: 0.4792824984, alpha: 1)
        self.cardView = #colorLiteral(red: 0.3542211652, green: 0.7981814742, blue: 0.4792824984, alpha: 1)
        self.cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static public func grayTheme() {
        self.tabBarTint = #colorLiteral(red: 0.6217569113, green: 0.6417064071, blue: 0.6415468454, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.writeButton = #colorLiteral(red: 0.6217569113, green: 0.6417064071, blue: 0.6415468454, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.6217569113, green: 0.6417064071, blue: 0.6415468454, alpha: 1)
        self.cardView = #colorLiteral(red: 0.6217569113, green: 0.6417064071, blue: 0.6415468454, alpha: 1)
        self.cardViewText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.buttonText = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static public func yellowTheme() {
        self.tabBarTint = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        self.tabBarBarTint = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        self.tabBarUnselectedTintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.writeButton = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        self.dateLabel = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        self.mainLabel = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        self.cardView = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        self.cardViewText = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.buttonText = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    }
    
    
    static public func updateDisplay() {
        let proxyButton = UIButton.appearance()
        proxyButton.backgroundColor = Theme.writeButton
        
        let proxyDateLabel = UILabel.appearance()
        proxyDateLabel.textColor = Theme.dateLabel
        
        let proxyTextLabel = UILabel.appearance()
        proxyTextLabel.textColor = Theme.mainLabel
        
        let proxyTabBarTint = UITabBar.appearance()
        proxyTabBarTint.tintColor = Theme.tabBarBarTint
        
        let proxyTapBarColor = UITabBar.appearance()
        proxyTapBarColor.barTintColor = Theme.tabBarTint
        
        let proxyTapBarUnselect = UITabBar.appearance()
        proxyTapBarUnselect.unselectedItemTintColor = Theme.tabBarUnselectedTintColor
        
        let proxyCellColor = UIView.appearance()
        proxyCellColor.backgroundColor = Theme.cardView
        
        let proxyCellTextColor = UILabel.appearance()
        proxyCellTextColor.textColor = Theme.cardViewText
        
        let proxyButtonText = UIButton.appearance()
        proxyButtonText.titleLabel?.textColor = Theme.buttonText
    }
    
}

let themeName: [String] = ["하늘하늘", "블루블루", "핑크핑크", "보라보라", "그린그린", "히색히색", "노랑노랑"]
