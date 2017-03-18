//
//  UserModule.swift
//  BeeHive-swift
//
//  Created by UgCode on 2017/3/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import BeeHive_swift

class UserModule: BHModuleProtocol {
    required init(_ context: BHContext) {
        print("UserModule Init")
    }
    
    func modSetUp(_ context: BHContext) {
        print("UserModule modSetUp")
        print(context.config.getAll())
    }
    
    func modWillResignActive(_ context: BHContext) {
        print("UserModule modWillResignActive")
    }
    
    func modDidEnterBackground(_ context: BHContext) {
        print("UserModule modDidEnterBackground")
    }
    
    func modWillEnterForeground(_ context: BHContext) {
        print("UserModule modWillEnterForeground")
    }
    
    func modDidBecomeActive(_ context: BHContext) {
        print("UserModule modDidBecomeActive")
    }
    
    func modWillTerminate(_ context: BHContext) {
        print("UserModule modWillTerminate")
    }
}
