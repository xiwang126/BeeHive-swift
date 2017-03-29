//
//  BHServiceManager.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

let kService: String = "service"
let kImpl: String = "impl"

public enum BHServiceManagerError: Error {
    case createServiceClassFailed
    case instantiationFailure
    case protocolHasBeenRegisted
}

open class BHServiceManager {
    
    // MARK: Public
    open static let shared = BHServiceManager()
    open var isEnableException: Bool = false
    
    var allServices: [ServiceName: String] = [:]
    var safeServices: [ServiceName: String] {
        lock.lock()
        let dic = allServices
        lock.unlock()
        return dic
    }
    lazy var lock = NSRecursiveLock()
    
    open func registerLocalServices() {
        let serviceConfigName = BHContext.shared.serviceConfigName
        guard let plistPath = Bundle.main.path(forResource: serviceConfigName, ofType: "plist") else {
            assert(false, "config file path error")
            return
        }
        guard let serviceList = NSArray(contentsOfFile: plistPath) as? [[AnyHashable: String]] else {
            assert(false, "read config error")
            return
        }

        lock.lock()
        for item in serviceList {
            let serviceName = ServiceName(item[kService]!)
            allServices[serviceName] = item[kImpl]
        }
        lock.unlock()
    }
    
//    open func registerAnnotationServices() {}
    
    open func register(service: ServiceName, implClass: AnyClass) {
        if !(implClass is BHServiceProtocol.Type) {
            assert(false, "\(NSStringFromClass(implClass)) module does not comply with BHServiceProtocol protocol")
        }
//        if implClass.conforms(to: service) && isEnableException {
//            assert(false, "\(NSStringFromClass(implClass)) module does not comply with \(NSStringFromProtocol(service)) protocol")
//        }
        if checkValid(service: service) && isEnableException {
            assert(false, "\(service.rawValue) protocol has been registed")
        }
        
        lock.lock()
        allServices[service] = NSStringFromClass(implClass)
        lock.unlock()
    }
    
    open func create(service: ServiceName) throws -> AnyObject {
        if !checkValid(service: service) && isEnableException {
            assert(false, "\(service) protocol has been registed")
            throw BHServiceManagerError.protocolHasBeenRegisted
        }
        guard let implClass = try serviceImplClass(service) as? BHServiceProtocol.Type else {
            assert(false, "service Impl Class is nill or not comply BHServiceProtocol")
            throw  BHServiceManagerError.instantiationFailure
        }

        let instanceCreater = { implClass.shareInstance() ?? (implClass.init() as AnyObject) }
        if implClass.singleton() {
            var implInstance = BHContext.shared.getServiceInstance(fromServiceName: service.rawValue)
            if implInstance == nil {
                implInstance = instanceCreater()
            }
            BHContext.shared.addService(withImplInstance: implInstance!, serviceName: service.rawValue)
            return implInstance!
        } else {
            return instanceCreater()
        }
    }
    
    // MARK: Private
    
    func serviceImplClass(_ service: ServiceName) throws -> AnyClass {
        for (key, value) in safeServices {
            if key == service {
                guard let implClass = NSClassFromString(value) else {
                    throw BHServiceManagerError.createServiceClassFailed
                }
                return implClass
            }
        }
        throw BHServiceManagerError.createServiceClassFailed
    }
    
    func checkValid(service: ServiceName) -> Bool {
        for (key, _) in safeServices {
            if key == service {
                return true
            }
        }
        return false
    }
    
}
