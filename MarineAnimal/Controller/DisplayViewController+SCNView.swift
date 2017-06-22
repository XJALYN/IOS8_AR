//
//  DisplayViewController+SCNView.swift
//  MarineAnimal
//
//  Created by xu jie on 2016/12/13.
//  Copyright © 2016年 xujie. All rights reserved.
//

import Foundation
import SceneKit

extension DisplayViewController{
    func setupScnView(){
        
        
      
    }
    
    func displayAnimation(_ animal:SCNNode){
        
        self.arView.showModel(node: animal,position: SCNVector3Make(0, 0, -1000))
    }
}
