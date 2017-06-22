//
//  Animal.swift
//  MarineAnimal
//
//  Created by xu jie on 2016/12/13.
//  Copyright © 2016年 xujie. All rights reserved.
//

import Foundation
import SceneKit
enum Animal:String{
    case chenQiYu = "cheqiyu"
    case dengLongYu = "denglongyu"
    case dianManYu = "dianmanyu"
    case fangYu = "fangyu"
    case haiGui = "haigui"
    case heTun = "hetun"
    case jianYu = "jianyu"
    case jinQiangYu = "jinqiangyu"
    case shaYu = "shayu"
    case shiZiYu = "shiziyu"
    case tianShiYu = "tianshiyu"
    case xiaoChouYu = "xiaochouyu"
    case xiaoHuangYu = "xiaohuangyu"
    case xiaoLvYu = "xiaolvyu"
    
    var node:SCNNode{
        return SCNScene(named: self.rawValue + ".dae")!.rootNode.clone()
    }
    var image:UIImage{
        return UIImage(named: self.rawValue + "-1.png")!
    }


}

class Marine{
    static var animals:[Animal] = [.chenQiYu,.dengLongYu,.dianManYu,.fangYu,.haiGui,.heTun,.jianYu,.jinQiangYu,.shaYu,.shiZiYu,.tianShiYu,.xiaoChouYu,.xiaoHuangYu,.xiaoLvYu]
}
