//
//  Dispatch+OSExtension.swift
//  ExtSwift
//
//  Created by xu jie on 2016/10/14.
//  Copyright © 2016年 xujie. All rights reserved.
//

import Foundation
extension DispatchQueue {
    static var os_userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var os_userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var os_background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    func os_after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    func os_syncResult<T>(_ closure: () -> T) -> T {
        var result: T!
        sync { result = closure() }
        return result
    }
}
