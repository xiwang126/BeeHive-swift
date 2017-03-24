//
//  BHServiceProtocol.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

public typealias ProtocolName = String

public protocol BHServiceProtocol {
    static func shareInstance() -> AnyObject?
    static func singleton() -> Bool
    init()
}

public extension BHServiceProtocol {
    
    static func shareInstance() -> AnyObject? {
        return nil
    }
    static func singleton() -> Bool {
        return false
    }
}
