//
//  NSCoding +Extension.swift
//  TangPoetry
//
//  Created by xu jie on 16/7/1.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import Foundation
extension NSObject{
   class func os_coder(aDecoder:NSCoder,object:NSObject){
        var count:UInt32 = 0
        var ivars = class_copyIvarList(object.classForCoder, &count)
        let copy = ivars
        for  _ in 0..<count{
            let ivar = ivar_getName(ivars?.pointee)
            let key = NSString(utf8String: ivar!) as! String
            ivars = ivars?.successor()
            object.setValue(aDecoder.decodeObject(forKey: key), forKey: key)
        }
        free(copy)
        
    }
    // 解码
   class  func os_encoderWidth(aCoder:NSCoder,object:AnyObject){
        var count:UInt32 = 0
        var ivars = class_copyIvarList(object.classForCoder, &count)
        let copy = ivars
        for _ in 0..<count{
            let ivar = ivar_getName(ivars?.pointee)
            let key = NSString(utf8String: ivar!)
            ivars = ivars?.successor()
            
            aCoder.encode(object.value(forKey: key as! String), forKey: key as! String)
        }
        free(copy)
    }
    // 深拷贝对象
    class func os_copyWidthObject(object:NSObject) -> AnyObject{
        let copyObject:AnyObject = object.copy() as AnyObject
        var count:UInt32 = 0
        var ivars = class_copyIvarList(object.classForCoder, &count)
        let copy = ivars
        for  _ in 0..<count{
            let ivar = ivar_getName(ivars?.pointee)
            let key = NSString(utf8String: ivar!) as! String
            ivars = ivars?.successor()
            
     
            copyObject.setValue(object.value(forKey: key), forKey: key)
        }
        free(copy)
        return copyObject
    }
    // 保存编码对象
   class func os_saveCoderObject(object:AnyObject,objectIdentifier:String){
        let mutableData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: mutableData)
        archiver.encode(object, forKey: objectIdentifier)
        archiver .finishEncoding()
        UserDefaults.standard.setValue(mutableData, forKey: objectIdentifier)
        
    }
    // 读取保存编码对象
   class  func os_readEncoderObject(objectIdentifier:String) -> AnyObject?{
        if let data =  UserDefaults.standard.value(forKey: objectIdentifier) as? NSData{
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            let object = unarchiver.decodeObject(forKey: objectIdentifier)
            unarchiver.finishDecoding()
            return object as AnyObject?
        }else{
            return nil
        }
    }
}

