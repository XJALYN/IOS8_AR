//
//  NSData+Extension.swift
//  TangPoetry
//
//  Created by xu jie on 16/6/30.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit

extension NSData{
    func os_toImage() -> UIImage?{
        guard let image = UIImage(data: self as Data) else {
            return nil
        }
        return image
    }
    func os_writeToTemByName(name:String){
      
        UserDefaults.standard.set(self, forKey: name)
      
    }
    class func os_readDataFromTemByName(name:String)-> NSData?{
        
        if let data = UserDefaults.standard.object(forKey: name) {
            return data as? NSData
        }
       
        return nil
    }
}
