//
//  UILabel+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 16/7/7.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import Foundation
import UIKit
extension UILabel{
    
// 设置字体之间的间隔
    var  os_lineSpace:CGFloat{
        set{
            let attributedString = NSMutableAttributedString(string: self.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            attributedString .addAttributes([NSParagraphStyleAttributeName:paragraphStyle], range: NSMakeRange(0, self.text!.os_length))
            self.attributedText = attributedString;
            self.sizeToFit()
        }
        get{
            return 0
        }
    }
    func os_text(text:String,lineSpace:CGFloat,color:UIColor,font:CGFloat){
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString .addAttributes([NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:color], range: NSMakeRange(0, self.text!.os_length))
        self.attributedText = attributedString;
        self.font = UIFont.systemFont(ofSize: font)
        self.sizeToFit()
    }
    
    func os_text(text:String,color:UIColor){
        let attributedString = NSMutableAttributedString(string: text)
        attributedString .addAttributes([NSForegroundColorAttributeName:color], range: NSMakeRange(0, self.text!.os_length))
        self.attributedText = attributedString;
        self.sizeToFit()
    }
    /// 追加一个有颜色的文字端
    func os_appendText(text:String,color:UIColor) {
        let attributedString = NSMutableAttributedString(attributedString:self.attributedText!)
        attributedString .append(NSAttributedString(string: "text", attributes: [NSForegroundColorAttributeName:color]))
        self.attributedText = attributedString
    }
    
    // 获取文字的在范围内的高度
    func os_getTextSizeByLimitSize(size:CGSize) -> CGRect{
        return self.textRect(forBounds: CGRect(x: 0,y: 0,width: size.width,height: size.height), limitedToNumberOfLines: 0)
    }
}
