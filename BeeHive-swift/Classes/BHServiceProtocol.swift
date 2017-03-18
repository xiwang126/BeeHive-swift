//
//  BHServiceProtocol.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

protocol BHServiceProtocol {
    func singleton() -> Bool
    static func shareInstance() -> Any
}
