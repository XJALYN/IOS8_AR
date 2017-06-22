//
//  ARSDKProtocol.swift
//  第四十二节 - AR的实现
//
//  Created by xu jie on 2017/4/23.
//  Copyright © 2017年 xujie. All rights reserved.
//

import Foundation
import SceneKit

protocol ARViewProtocol {
    func addModelFile(file:URL,position:SCNVector3)
}
