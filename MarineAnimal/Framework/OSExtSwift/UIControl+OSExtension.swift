//
//  UIController+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 16/7/12.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit
extension UIControl{
    
    //MARK: -增加一个点击回调
    func os_addActionBlock(event: UIControlEvents, block:  @escaping ControlBlock) {
        let blockContainer: BlockContainer = BlockContainer()
        blockContainer.controlBlock = block
        self.blockContainer = blockContainer
        self.addTarget(self, action: #selector(UIControl.action(control:)), for: event)
    }
    
    
    func action(control: UIControl) {
        guard (control === self) else {
            return
        }
        guard (self.blockContainer?.controlBlock != nil) else {
            return
        }
        self.blockContainer!.controlBlock!(self)
    }

}
