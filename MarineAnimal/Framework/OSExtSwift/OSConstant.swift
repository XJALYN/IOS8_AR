//
//  OSConstant.swift
//  ExtSwift
//
//  Created by xu jie on 16/7/7.
//  Copyright © 2016年 os. All rights reserved.
//

import Foundation
import UIKit
///  参考图的宽度和高度
let  referenceWidth:CGFloat = 320
let  referenceHeight:CGFloat = 560

/// 获取屏幕的实际宽
func os_get_screen_width()->CGFloat {
    return UIScreen.main.bounds.size.width
}

/// 获取屏幕的实际高
func os_get_screen_height()->CGFloat{
    return UIScreen.main.bounds.size.height
}

/// 获取适配屏幕的宽
func os_get_adapt_Height(height:CGFloat) -> CGFloat{
    return height * os_get_screen_height()/referenceHeight
}
/// 获取适配屏幕的高
func os_get_adapt_width(width:CGFloat)-> CGFloat{
    return width * os_get_screen_width()/referenceWidth
}

/// 获取视图的宽
func os_get_rect_width(rect:CGRect)->CGFloat{
    return rect.size.width
}
/// 获取视图的高
func os_get_rect_height(rect:CGRect)->CGFloat{
    return rect.size.height
}

/// 获取X轴坐标
func os_get_rect_x(rect:CGRect)->CGFloat{
    return rect.origin.x
}
/// 获取y轴坐标
func os_get_rect_y(rect:CGRect)-> CGFloat{
    return rect.origin.y
}

/// 获取视图的x 坐标
func os_get_view_x(view:UIView) -> CGFloat{
    return os_get_rect_x(rect: view.frame)
}

/// 获取视图的y坐标
func os_get_view_y(view:UIView) -> CGFloat{
    return os_get_rect_y(rect: view.frame)
}

/// 获取视图的宽
func os_get_view_width(view:UIView) -> CGFloat{
    return os_get_rect_width(rect: view.frame)
}

/// 获取视图的高
func os_get_view_height(view:UIView) ->  CGFloat{
    return os_get_rect_height(rect: view.frame)
}

// 扩展颜色
func os_rgb(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

/// 扩展颜色
func os_rgba(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
