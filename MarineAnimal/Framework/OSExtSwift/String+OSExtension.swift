//
//  String+Extension.swift
//  ExtSwift
//
//  Created by xu jie on 16/6/29.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit


extension String{
    
    /// 字符串截取
    subscript (first:Int,last:Int) -> String? {
        get{
            if self.lengthOfBytes(using: String.Encoding.utf8) <= last {
             return nil
            }else{
               
                let lower = self.index(self.startIndex, offsetBy: first)
                let upper = self.index(self.startIndex, offsetBy: last)
                let range =   Range(uncheckedBounds: (lower: lower, upper: upper))
                return self.substring(with: range)
            }
        }
    }
    
    subscript (range: ClosedRange<Int>) -> String? {
        get{
            
            if  range.lowerBound < 0 || range.lowerBound > range.upperBound || range.upperBound > self.characters.count{
                return nil
            }else{
                let lower = self.index(self.startIndex, offsetBy: range.lowerBound)
                let upper = self.index(self.startIndex, offsetBy: range.upperBound)
                let range =   Range(uncheckedBounds: (lower: lower, upper: upper))
                return self.substring(with: range)
            }
        }
    }
    
    /// 转换成Int 类型
    func os_toInt()->Int{
        guard let result = Int(self) else{
            return 0
        }
        return result
    }
    
    /// 转换成float 类型
    func os_toFloat() -> Float{
        guard let result = Float(self) else{
            return 0
        }
        return result
    }
    
    /// 正则表达式验证手机号码
    func os_isTelphone() -> Bool{
        let regex = try! NSRegularExpression(pattern: "^1[3|4|5|7|8][0-9]\\d{8}$", options: .caseInsensitive)
        let result = regex.firstMatch(in: self, options: .anchored, range:NSRange(location: 0, length: self.lengthOfBytes(using: String.Encoding.utf8)) )
        if (result == nil) {
            
            return true
        }
        return false
    }
    
    /// 正则验证输入验证码的合理性
    func os_isVerifyCode() -> Bool{
        let regex1 = try! NSRegularExpression(pattern: "^[0-9]{4,15}$", options: .caseInsensitive)
        let result1 = regex1.firstMatch(in: self , options: .anchored, range:NSRange(location: 0, length: self.characters.count) )
        if (result1 == nil) {
            return false
        }
        return true
    }
    
    /// 检验是不是邮箱
    func os_isEmail() -> Bool{
        let regex1 = try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .caseInsensitive)
        let result1 = regex1.firstMatch(in: self , options: .anchored, range:NSRange(location: 0, length: self.characters.count) )
        if (result1 == nil) {
            return false
        }
        return true
    }
    
    /// 获取长度
    var os_length:Int{
        return self.characters.count
    }
    
    /// 汉字转拼音，带声调
    var os_letter:String{
        if (self.os_length > 0) {
            let mutableString = NSMutableString(string: self)
            if    CFStringTransform(mutableString,UnsafeMutablePointer(bitPattern: 0),kCFStringTransformStripDiacritics, false){
                return mutableString as String
            }
        }
        return self
    }
    
    /// 汉字转字母，没有声调
    var os_english:String{
        if (self.os_length > 0) {
            let mutableString = NSMutableString(string: self)
            if    CFStringTransform(mutableString,UnsafeMutablePointer(bitPattern: 0),kCFStringTransformMandarinLatin, false){ 
                if    CFStringTransform(mutableString,UnsafeMutablePointer(bitPattern: 0),kCFStringTransformStripDiacritics, false){
                    return mutableString as String
                }
                return mutableString as String
            }
            
        }
        return self
    }
    /// 生成随机订单
    static func os_generateTradeNO(bitLength:Int) -> String
    {
        let kNumber = bitLength;
        let sourceStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        let resultStr = NSMutableString();
        let _:UnsafeMutablePointer<time_t> = UnsafeMutablePointer(bitPattern: 0)!
        
        //srand(UInt32(time(time1)))
        
         for _ in 0...kNumber
         {
            
            
            let  index:Int = Int(Int32(arc4random()) % Int32(sourceStr.os_length))
            let oneStr = sourceStr[index,index];
            resultStr.append(oneStr!);
        }
            return resultStr as String;
    }
    
    /// 获取字符范围大小 
    func os_getSizeByLimitSize(size:CGSize,fontSize:CGFloat) -> CGSize{
       let string = self as NSString
      return  string.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    /// 重复数字填充
    static func os_stringWithString(string:String,count:Int)->String{
        var result:String = ""
        for _ in 0..<count{
            result += string
            
        }
        return result
    
    }
    
    /**
     *  将文字转换成图片
     */
    func os_toConvertImageWithFontSize(fontSize:CGFloat,maxWidth:CGFloat,textColor:UIColor)-> UIImage{
      let size =  self.os_getSizeByLimitSize(size: CGSize(width: maxWidth,height: 10000), fontSize: fontSize)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context!.setCharacterSpacing(10)
        context!.setTextDrawingMode(.fillStroke)
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha :CGFloat = 0
        textColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context!.setFillColor(red: red, green: green, blue: blue , alpha: alpha);
        context!.setStrokeColor(red: 0, green: 1, blue: 0, alpha: 1)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        (self as NSString).draw(in: rect, withAttributes: [NSForegroundColorAttributeName:textColor])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }

}
