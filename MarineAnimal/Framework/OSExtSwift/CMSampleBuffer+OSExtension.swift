//
//  CMSampleBuffer+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 2016/12/7.
//  Copyright © 2016年 xujie. All rights reserved.
//

import UIKit
import CoreMedia

extension CMSampleBuffer{
    var os_data:UnsafePointer<UInt8>{
        let imageBuffer = CMSampleBufferGetImageBuffer(self)!
        /// 锁定缓冲区地址(Lock the pixel buffer)
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(kCVPixelFormatType_32BGRA)))
        /// 获取缓冲区地址(get base Address)
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
        
        // Get the number of bytes per row for the pixel buffer
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        // Get the pixel buffer width and height
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        
        // Create a device-dependent RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Create a bitmap graphics context with the sample buffer dataCGImageAlphaInfo.none.rawValue)//premultipliedFirst/noneSkipFirst
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        
        let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        // Create a Quartz image from the pixel data in the bitmap graphics context
        let quartzImage = context!.makeImage();
        // Unlock the pixel buffer
        
        CVPixelBufferUnlockBaseAddress(imageBuffer,CVPixelBufferLockFlags(rawValue: CVOptionFlags(kCVPixelFormatType_32BGRA)))
        
        let pixelData = quartzImage?.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        return data
    }
}


