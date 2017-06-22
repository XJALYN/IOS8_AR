//
//  DisplayViewController+UI.swift
//  MarineAnimal
//
//  Created by xu jie on 2016/12/14.
//  Copyright © 2016年 xujie. All rights reserved.
//

import Foundation
import SceneKit

extension DisplayViewController{
    func initUI(){
        self.detialBackgroundView.layer.contents = UIImage(named: "background.jpg")?.cgImage
    }



}
