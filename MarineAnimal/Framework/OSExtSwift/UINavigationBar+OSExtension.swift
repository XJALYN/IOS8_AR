//
//  UINavigationBar+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 2016/12/7.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit

extension UINavigationBar{
   static func os_setBackgroundColor(bgcolor:UIColor,titleColor:UIColor){
        UINavigationBar.appearance().barTintColor = bgcolor
        UINavigationBar.appearance().tintColor = titleColor
    }

}
