//
//  UIImageView+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 16/7/7.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit
extension UIImageView{
    func os_imageUrl(imageUrl:NSString,placeImage:UIImage){
    
       let destionPath = NSHomeDirectory() + "/Documents/" + imageUrl.lastPathComponent
        if  let image = UIImage(contentsOfFile: destionPath){
            self.image = image;
            return
        }else{
            self.image = placeImage;
            if #available(iOS 8.0, *) {
                DispatchQueue.global().async {
                    if let data = NSData(contentsOf: NSURL(string: imageUrl as String)! as URL){
                        data.write(toFile: destionPath, atomically: true)
                        DispatchQueue.main.sync {
                            self.image = UIImage(data: data as Data )
                        }
                    }
                    
                }
            } else {
                // Fallback on earlier versions
            }
        
    }
   
}
}
