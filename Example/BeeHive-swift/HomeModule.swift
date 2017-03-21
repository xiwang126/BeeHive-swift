//
//  HomeModule.swift
//  BeeHive-swift
//
//  Created by UgCode on 2017/3/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import BeeHive_swift

class HomeModule: BHModuleProtocol {
    required init(_ context: BHContext) {
        print("HomeModule Init")
    }
    
    func modSetUp(_ context: BHContext) {
        BeeHive.shared.registerService(HomeModuleServiceProtocol_Name, service: HomeModuleService.self)
        print("HomeModule modSetUp")
    }
    
    func modWillResignActive(_ context: BHContext) {
        print("HomeModule modWillResignActive")
    }
    
    func modDidEnterBackground(_ context: BHContext) {
        print("HomeModule modDidEnterBackground")
    }
    
    func modWillEnterForeground(_ context: BHContext) {
        print("HomeModule modWillEnterForeground")
    }
    
    func modDidBecomeActive(_ context: BHContext) {
        print("HomeModule modDidBecomeActive")
    }
    
    func modWillTerminate(_ context: BHContext) {
        print("HomeModule modWillTerminate")
    }
}
