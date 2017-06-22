//
//  GCImage+OSExtension.swift
//  Polygraph
//
//  Created by xu jie on 2016/12/8.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit

extension CGImage{
    var os_image:UIImage{
        return UIImage(cgImage: self)
    }
}
