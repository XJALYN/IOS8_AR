//
//  ExtSwift.swift
//  ExtSwift
//
//  Created by xu jie on 2016/12/11.
//  Copyright © 2016年 xujie. All rights reserved.
//

import Foundation
public struct Ext<Base> {
    /// Base object to extend.
    public let base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has reactive extensions.
public protocol ExtCompatible {
    associatedtype CompatibleType
    
    static var ext: Ext<CompatibleType>.Type { get set }
    
    var ext: Ext<CompatibleType> { get set }
}

extension ExtCompatible {
    /// Reactive extensions.
    public static var ext: Ext<Self>.Type {
        get {
            return Ext<Self>.self
        }
        set {
         
        }
    }
    
    /// Reactive extensions.
    public var ext: Ext<Self> {
        get {
            return Ext(self)
        }
        set {
           
        }
    }
}


/// Extend NSObject with `rx` proxy.
extension NSObject: ExtCompatible {
 
 }
