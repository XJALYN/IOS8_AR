//
//  Array+Extension.swift
//  TangPoetry
//
//  Created by xu jie on 16/7/1.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import Foundation
extension Array{
     func os_toStringArray()->[String]{
        var stringArray:[String] = []
        for  number in self {
            stringArray.append("\(number)")
        }
       return stringArray
    }
}
