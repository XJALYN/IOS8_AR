//
//  UIViewController+Extension.swift
//  ExtSwift
//
//  Created by xu jie on 16/6/30.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit
extension UIViewController{
    
    /********************************视图扩展***********************************/
    // MARK: - 显示提示框
    func os_handleErrorWithTitle(title:String?, message: String?, error: NSError? = nil) {
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "确定").show()
        }
    }
    
    // MARK: - 显示加载框
    func showAlertView(title:String,hiddenDelay:TimeInterval) -> UIView{
        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: os_get_adapt_width(width: 100), height: os_get_adapt_width(width: 100)));
         alertView.center = self.view.center
         alertView.os_cornerRadius = 5
         alertView.backgroundColor = os_rgb(r: 246, g: 211, b: 39)
        let titleLable  = UILabel(frame: CGRect(x: 0, y: 10, width: alertView.os_width, height: 20))
        titleLable.textAlignment = .center
        titleLable.center = CGPoint(x:alertView.os_width/2,y:alertView.os_height/2)
        titleLable.text = title
        titleLable.textColor = UIColor.white
        alertView.addSubview(titleLable)
        self.view.addSubview(alertView)
        if #available(iOS 8.0, *) {
            if hiddenDelay != 0 {
                let dealline = DispatchTime.init(uptimeNanoseconds: UInt64(hiddenDelay))
                DispatchQueue.main.asyncAfter(deadline: dealline, execute: { 
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                        alertView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                        }, completion: { (flag) in
                            alertView.removeFromSuperview()
                    })

                })
                
            }
        } else {
            // Fallback on earlier versions
        }
        return alertView
    }
    
    // MARK: - 显示图片选择框架
    func presentImagePickViewController(sourceType:UIImagePickerControllerSourceType,allowsEditing:Bool,delegate:UIImagePickerControllerDelegate&UINavigationControllerDelegate) -> UIImagePickerController{
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.os_configur(sourceType: sourceType, allowsEditing: allowsEditing, delegate: delegate)
        self.present(imagePickerViewController, animated: true, completion: nil)
        return imagePickerViewController
        
    }
    
    
    
    
}
