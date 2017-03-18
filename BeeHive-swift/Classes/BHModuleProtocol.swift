//
//  BHModuleProtocol.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

public protocol BHModuleProtocol {
    //如果不去设置Level默认是Normal = 1
    static func moduleLevel() -> Int
    
    func async() -> Bool
    
    init(_ context: BHContext)
    
    func modSetUp(_ context: BHContext)
    
//    func modInit(_ context: BHContext)
    
    func modSplash(_ context: BHContext)
    
    func modQuickAction(_ context: BHContext)
    
    func modTearDown(_ context: BHContext)
    
    func modWillResignActive(_ context: BHContext)
    
    func modDidEnterBackground(_ context: BHContext)
    
    func modWillEnterForeground(_ context: BHContext)
    
    func modDidBecomeActive(_ context: BHContext)
    
    func modWillTerminate(_ context: BHContext)
    
    func modUnmount(_ context: BHContext)
    
    func modOpenURL(_ context: BHContext)
    
    func modDidReceiveMemoryWaring(_ context: BHContext)
    
    func modDidFailToRegister(forRemoteNotifications context: BHContext)
    
    func modDidRegister(forRemoteNotifications context: BHContext)
    
    func modDidReceiveRemoteNotification(_ context: BHContext)
    
    func modDidReceiveLocalNotification(_ context: BHContext)
    
    func modWillContinueUserActivity(_ context: BHContext)
    
    func modContinueUserActivity(_ context: BHContext)
    
    func modDidFail(toContinueUserActivity context: BHContext)
    
    func modDidUpdateContinueUserActivity(_ context: BHContext)
    
    func modDidCustomEvent(_ context: BHContext)
}

public extension BHModuleProtocol {
    static func moduleLevel() -> Int { return 1 }

    func async() -> Bool { return false }

    func modSetUp(_ context: BHContext) {
    }

    func modSplash(_ context: BHContext) {
    }

    func modQuickAction(_ context: BHContext) {
    }

    func modTearDown(_ context: BHContext) {
    }

    func modWillResignActive(_ context: BHContext) {
    }

    func modDidEnterBackground(_ context: BHContext) {
    }

    func modWillEnterForeground(_ context: BHContext) {
    }

    func modDidBecomeActive(_ context: BHContext) {
    }

    func modWillTerminate(_ context: BHContext) {
    }

    func modUnmount(_ context: BHContext) {
    }

    func modOpenURL(_ context: BHContext) {
    }

    func modDidReceiveMemoryWaring(_ context: BHContext) {
    }

    func modDidFailToRegister(forRemoteNotifications context: BHContext) {
    }

    func modDidRegister(forRemoteNotifications context: BHContext) {
    }

    func modDidReceiveRemoteNotification(_ context: BHContext) {
    }

    func modDidReceiveLocalNotification(_ context: BHContext) {
    }

    func modWillContinueUserActivity(_ context: BHContext) {
    }

    func modContinueUserActivity(_ context: BHContext) {
    }

    func modDidFail(toContinueUserActivity context: BHContext) {
    }

    func modDidUpdateContinueUserActivity(_ context: BHContext) {
    }

    func modDidCustomEvent(_ context: BHContext) {
    }

}
