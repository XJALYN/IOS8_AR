//
//  UIImagePickerController.swift
//  TangPoetry
//
//  Created by xu jie on 16/7/1.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit
extension UIImagePickerController{
    // MARK : 导航背景颜色
    var os_navigationBackgroundColor:UIColor{
        set{
            self.navigationBar.tintColor = newValue
        }
        get{
          return self.navigationBar.tintColor
        }
    }
    
    // text颜色
    var os_titleColor:UIColor{
        set{
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:newValue]
        }
        get{
            return  self.navigationBar.titleTextAttributes![NSForegroundColorAttributeName] as! UIColor
        }
    }
    
    // 左右item 颜色
    var os_tintColor:UIColor{
        set{
           self.navigationBar.tintColor = newValue 
        }
        get{
         return self.navigationBar.tintColor
        }
    }
    
    func os_configur(sourceType:UIImagePickerControllerSourceType,allowsEditing:Bool,delegate:UIImagePickerControllerDelegate & UINavigationControllerDelegate){
        self.sourceType = sourceType
        self.allowsEditing = allowsEditing
        self.delegate = delegate
    }
   
    
}
