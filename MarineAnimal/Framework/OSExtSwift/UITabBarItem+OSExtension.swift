//
//  UITabbar+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 2016/12/7.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit
extension UITabBarItem{
    static func os_setNormalColor(_ normalColor:UIColor,selectColor:UIColor){
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : normalColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : selectColor], for: .selected)
    }
}
