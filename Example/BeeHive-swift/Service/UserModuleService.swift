//
//  UserModuleService.swift
//  BeeHive-swift
//
//  Created by UgCode on 2017/3/20.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import BeeHive_swift

let UserModuleServiceProtocol_Name = "UserModuleServiceProtocol"

protocol UserModuleServiceProtocol: BHServiceProtocol {
    func login() -> String
}

class UserModuleService: UserModuleServiceProtocol {
    
    static func singleton() -> Bool { return true }
    
    let uuid = UUID().uuidString
    
    required init() {}
    
    internal func login() -> String {
        return uuid
    }
}
