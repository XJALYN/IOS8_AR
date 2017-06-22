//
//  XAuthorizeCenter.swift
//  TangPoetry
//
//  Created by xu jie on 16/7/1.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import Foundation
import Photos
import AddressBook
import AddressBookUI

extension UIApplication{
    /// 是否授权相机
    class func os_isAuthorizeCamara() -> Bool{
    let  authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    if (authStatus == .restricted || authStatus == .denied)
    {
        return false
    }
        return true
    }
    
    /// 是否授权图片相册
   class func os_isAuthorizeLibrary() -> Bool{
    if #available(iOS 8.0, *) {
        let authStatus =   PHPhotoLibrary.authorizationStatus()
        if (authStatus == .restricted || authStatus == .denied)
        {
            return false
        }
    } else {
        // Fallback on earlier versions
    }
    
        return true
    }
    
    /// 授权定位
    class func os_isAuthorizeLocation()-> Bool{
     let statue = CLLocationManager.authorizationStatus()
        if #available(iOS 8.0, *) {
            if statue == CLAuthorizationStatus.authorizedAlways || statue == CLAuthorizationStatus.authorizedWhenInUse{
                return true
            }
        } else {
            // Fallback on earlier versions
        }
        return false
    }
    
    /// 是否授权麦克风
    class func os_isAuthorize(  authorPermisson :@escaping ((Bool)->Void)){
        AVAudioSession.sharedInstance().requestRecordPermission { (flag) in
            authorPermisson(flag)
        }
    }
    
    /// 授权通讯录
    class func os_isAuthorizeAddressBook() -> Bool{
        let  authStatus = ABAddressBookGetAuthorizationStatus()
        if authStatus == .authorized{
            return true
        }
        return false
    }
}
