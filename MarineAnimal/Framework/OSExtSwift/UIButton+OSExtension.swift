//
//  UIButton+Extension.swift
//  TangPoetry
//
//  Created by xu jie on 16/6/30.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit

extension UIButton {
   
    // 设置字体状态 倒计时用
    func os_setStableTitle(title:String,forState:UIControlState){
        self.titleLabel?.text = title
        self.setTitle(title, for: .normal)
    }
    
  }




