//
//  BHServiceManager.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

class BHServiceManager {
    
    // MARK: Public
    public var isEnableException: Bool = false
    
    public static let shared = BHServiceManager()
    
    public func registerLocalServices() {
    }
    
    public func registerAnnotationServices() {
    }
    
    public func registerService(_ service: Protocol, implClass: AnyClass) {
    }
    
    public func createService(_ service: Protocol) -> AnyClass {
        return BHServiceManager.self
    }
    
    // MARK: Private
    
    
}
