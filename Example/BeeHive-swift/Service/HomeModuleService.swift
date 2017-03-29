//
//  HomeModuleService.swift
//  BeeHive-swift
//
//  Created by UgCode on 2017/3/21.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import BeeHive_swift

extension ServiceName {
    static let HomeModuleService = ServiceName("HomeModuleServiceProtocol")
}

protocol HomeModuleServiceProtocol: BHServiceProtocol {
    func presentHomeController(to presentedController: UIViewController)
}

class HomeModuleService: HomeModuleServiceProtocol {
    required init() {}
    
    func presentHomeController(to presentedController: UIViewController) {
        let homeController = HomeViewController()
        presentedController.present(homeController, animated: true, completion: nil)
    }
}
