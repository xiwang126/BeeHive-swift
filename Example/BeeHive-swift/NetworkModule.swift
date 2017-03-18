//
//  NetworkModule.swift
//  BeeHive-swift
//
//  Created by UgCode on 2017/3/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import BeeHive_swift

class NetworkModule: BHModuleProtocol {
    required init(_ context: BHContext) {
        print("NetworkModule Init")
    }
    
    func modSetUp(_ context: BHContext) {
        print("NetworkModule modSetUp")
    }
    
    func modWillResignActive(_ context: BHContext) {
        print("NetworkModule modWillResignActive")
    }
    
    func modDidEnterBackground(_ context: BHContext) {
        print("NetworkModule modDidEnterBackground")
    }
    
    func modWillEnterForeground(_ context: BHContext) {
        print("NetworkModule modWillEnterForeground")
    }
    
    func modDidBecomeActive(_ context: BHContext) {
        print("NetworkModule modDidBecomeActive")
    }
    
    func modWillTerminate(_ context: BHContext) {
        print("NetworkModule modWillTerminate")
    }
}
