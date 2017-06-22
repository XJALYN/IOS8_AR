//
//  UIAlertController+Extension.swift
//  麦惠
//
//  Created by xu jie on 16/10/10.
//  Copyright © 2016年 上海佰贝科技发展有限公司. All rights reserved.
//

import UIKit

extension UIAlertController{
    // MARK: 添加一个行为
    /// 添加一个行为不执行
    /// - Parameters:
    ///     - title:  标题
    ///     - style:  风格
    /// - Returns: 无
    @discardableResult
    func os_addAction(title:String,style:UIAlertActionStyle,handle: ((UIAlertAction) -> ())? = nil)->Self{
        self.addAction(UIAlertAction(title: title, style: style, handler: handle))
        return self
    }
    
  
    
    // MARK: 扩展初始化方法,增加一个行为
    /// 扩展初始化方法,增加一个行为
    /// - Parameters:
    ///     - title:  标题
    ///     - message:  消息
    ///     - preferredStyle:控制器风格默认为.alert
    /// - Returns: 无
    convenience init(title:String,message:String?,cancle:String,preferredStyle:UIAlertControllerStyle = .alert){
        self.init(title:title,message:message,preferredStyle:preferredStyle)
        let action = UIAlertAction(title: cancle, style: .cancel, handler: nil)
        self.addAction(action)
    }
    
}
