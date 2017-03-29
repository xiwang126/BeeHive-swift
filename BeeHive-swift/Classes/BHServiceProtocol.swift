//
//  BHServiceProtocol.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

public struct ServiceName: RawRepresentable, Equatable, Hashable {

    public private(set) var rawValue: String

    public var hashValue: Int {
        return rawValue.hashValue
    }

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public static func ==(lhs: ServiceName, rhs: ServiceName) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

/*
extension ServiceName {
    public static let UserServer = ServiceName("UserService")
}
*/

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
