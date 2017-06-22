//
//  UIImage+Detector.swift
//  face
//
//  Created by xu jie on 2016/11/28.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit

extension UIImage {
    func os_synchronizeDetectiveFace()->[CIFaceFeature]{
        /// 第一步 设置
        let imageOptions =  NSDictionary(object: NSNumber(value: 5) as NSNumber, forKey: CIDetectorImageOrientation as NSString)
        /// 第二步 转为为cgimage
        let personciImage = CIImage(cgImage: self.cgImage!)
        /// 第三步 设置识别精度
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        /// 第四步创建识别器
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        /// 第五步 识别照片
        let faces = faceDetector?.features(in: personciImage, options: imageOptions as? [String : AnyObject])
        
        /// 第六步 解析人脸
        guard let findFaces = faces as? [CIFaceFeature] else {
            return []
        }
        return findFaces
    }
    
    func os_asychronizeDetectiveFace(result:@escaping ([CIFaceFeature])->()){
        DispatchQueue.global().async {
            let faces =  self.os_synchronizeDetectiveFace()
            DispatchQueue.main.async {
                result(faces)
            }
        }
    }
    
    var os_fixOrientation:UIImage{
        if self.imageOrientation == .up{
            
            return self
        }
        
        var transform = CGAffineTransform(translationX: 0, y: 0)
        print(transform.isIdentity)
        switch self.imageOrientation {
        case let x where x == .downMirrored || x == .down:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case let x where x == .left || x == .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(M_PI_2));
        case let x where x == .right || x == .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: -CGFloat(M_PI_2));
            
        default: break
            
        }
        
        switch self.imageOrientation {
        case  let x where x == .upMirrored || x == .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        case let x where x == .leftMirrored || x == .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
            
        default: break
            
        }
        let  ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                             bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                             space: self.cgImage!.colorSpace!,
                             bitmapInfo: self.cgImage!.bitmapInfo.rawValue);
        ctx!.concatenate(transform);
        
        
        switch  (self.imageOrientation) {
        case let x where x == .left || x == .leftMirrored || x == .right || x == .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x:0,y:0,width:self.size.height,height:self.size.width))
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x:0,y:0,width:self.size.width,height:self.size.height))
            break
        }
        let cgimg = ctx!.makeImage();
        let img = UIImage(cgImage: cgimg!)
        print(img)
        return img
    }
    
   
    
    
}
