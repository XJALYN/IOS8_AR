//
//  UImage+Extension.swift
//  ExtSwift
//
//  Created by xu jie on 16/6/29.
//  Copyright © 2016年 上海亚疆网络科技有限公司. All rights reserved.
//

import UIKit
import CoreImage
import Accelerate
import CoreGraphics
extension UIImage{
    
    /// 图片的宽度
    var os_width:CGFloat{
        return self.size.width
    }
    
    /// 图片的高度
    var os_height:CGFloat{
        return self.size.height
    }
    
    /// 获取模糊视图
    func os_getBlurImageWithLevel( blur:CGFloat) -> UIImage{
        var blur1 = blur
        if (blur1 < 0.0 || blur1 > 1.0) {
            blur1 = 0.5
        }
        var boxSize:Int = Int(CGFloat(blur1) * 100)
        boxSize = boxSize - (boxSize % 2) + 1;
       print(boxSize)
        // 图片对象的引用
        let img = self.cgImage;
        // 设置两个缓冲区一个输入，一个输出
        var  inBuffer:vImage_Buffer = vImage_Buffer()
        var outBuffer:vImage_Buffer = vImage_Buffer()
        // 记录转换错误信息
        var error:vImage_Error
        // 像素缓冲
        var pixelBuffer:UnsafeMutableRawPointer?;
        // 图片数据的信息结构体
        let inProvider = img!.dataProvider;
        // 位图数据
        let inBitmapData = inProvider!.data;
        // 获取图片的宽和高
        inBuffer.width = UInt(img!.width)
        inBuffer.height = UInt(img!.height)
        // 获取图片的位数据大小
        inBuffer.rowBytes = img!.bytesPerRow;
        // 图片的位图数据
        let bytePtr = CFDataGetBytePtr(inBitmapData)
        
        inBuffer.data = UnsafeMutableRawPointer(mutating: bytePtr)
        // 设置缓冲大小
        let memory = malloc(img!.bytesPerRow *
            img!.height)
        pixelBuffer = UnsafeMutableRawPointer(memory)!
        if(pixelBuffer == nil) {
            return self
        }
        // 设置接受处理后数据的缓冲区
        outBuffer.data = pixelBuffer;
        outBuffer.width = UInt(img!.width)
        outBuffer.height = UInt(img!.height)
        outBuffer.rowBytes = img!.bytesPerRow;
        // 进行高斯模糊操作
        error = vImageBoxConvolve_ARGB8888(&inBuffer,
        &outBuffer,
        nil,
        0,
        0,
        UInt32(boxSize),
        UInt32(boxSize),
        nil,
        UInt32(kvImageEdgeExtend));
        if (error != 0) {
            print("转换出错")
        }
       let colorSpace = CGColorSpaceCreateDeviceRGB();
        let ctx = CGContext(
            data: outBuffer.data,
            width: Int(outBuffer.width),
            height: Int(outBuffer.height),
            bitsPerComponent: 8,
            bytesPerRow: outBuffer.rowBytes,
            space: colorSpace,
            bitmapInfo: 5);
        
        let  imageRef = ctx!.makeImage ();
        let returnImage = UIImage(cgImage: imageRef!)
        //clean up
        free(pixelBuffer);
        return returnImage;
    }
    
    /// 切割图片
    func os_getCornerImageWithBorder(borderWidth:CGFloat,borderColor:UIColor) -> UIImage{
        let radius = self.size.width < self.size.height ? self.size.width/2 : self.size.height/2
        let imageWidth = size.width + 2 * borderWidth
        let  imageHeight = size.height + 2 * borderWidth;
        UIGraphicsBeginImageContextWithOptions(CGSize(width:imageWidth,height:imageHeight), true, 0.0);
        //3. 获取当前上下文
        UIGraphicsGetCurrentContext()
        //4. 画圆圈
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x:imageWidth * 0.5, y:imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        draw(in: CGRect(x: borderWidth, y: borderWidth, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //8. 结束上下文
        UIGraphicsEndImageContext();
        return image!
    }
    
    /// 按比例缩放图片
    func os_scale(scale:CGFloat) -> UIImage{
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x:0, y:0, width:size.width*scale, height:size.height*scale))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
    /// 按指定大小缩放
    func os_resetSize(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }

    /// 获取源模式照片，视图显示的将是原图
     func os_originModeImage()-> UIImage{
     return  self.withRenderingMode(.alwaysOriginal)
    }
    
    /// 将图片进行base64 编码 字符串
    func os_encodeToBase64StringCompressionQuality(quality:CGFloat)->String?{

      return  UIImageJPEGRepresentation(self, quality)?.base64EncodedString(options: .lineLength64Characters)
    }
    
    /// 将图片进行base64 编码 NSData 类型
    func os_encodeToBase64DataCompressionQuality(quality:CGFloat) -> Data?{
        return  UIImageJPEGRepresentation(self, quality)?.base64EncodedData(options: .lineLength64Characters)
    }
    
    /// 将图片保存在本地并且返回路径
    func os_getImagePathDocumentPathWithName(name:String) -> String {
        var filePath:String
        var data:Data
        var type:String
        if (UIImagePNGRepresentation(self) == nil) {
            data = UIImageJPEGRepresentation(self, 1.0)!
            type = "jpg"
        } else {
            data = UIImagePNGRepresentation(self)!
            type = "png"
        }
    
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        let DocumentsPath = NSHomeDirectory() + "/Documents"
        //文件管理器
        let fileManager = FileManager.default
        //把刚刚图片转换的data对象拷贝至沙盒中
        try!  fileManager.createDirectory(atPath: DocumentsPath,  withIntermediateDirectories: true, attributes: nil)
        let imagePath = "/\(name).\(type)"
        //得到选择后沙盒中图片的完整路径
        filePath = DocumentsPath + imagePath
        fileManager .createFile(atPath: filePath, contents: data as Data, attributes: nil)
        return filePath;
    }
    
    /// 获取rgba 数据
    var os_rgbaDataInfo:(NSData,Int,Int)?{
        let cgImage = self.cgImage
        guard let _ = cgImage else {return nil}
        let width = cgImage!.width
        let height = cgImage!.height
        let imageData = NSMutableData(length: height*width*4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgContext = CGContext(data: imageData!.mutableBytes, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4*width, space: colorSpace, bitmapInfo: 1) //CGImageAlphaInfo
        cgContext!.translateBy(x: 0, y: CGFloat(height))
        cgContext!.scaleBy(x: 1, y: -1.0)
        cgContext?.draw(cgImage!, in: CGRect(x:0, y:0, width:CGFloat(width), height:CGFloat(height)))
        return (imageData!,width,height)
        
    }
    /**
     *  保存在本地
     */
    func os_savaPhotosAlbum(){
        UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
    }
    
    /// 获取像素数据
    func os_getPixelColor(pos: CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}
