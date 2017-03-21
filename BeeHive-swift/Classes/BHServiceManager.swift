//
//  BHServiceManager.swift
//  Pods
//
//  Created by UgCode on 2017/3/14.
//
//

import Foundation

public typealias ProtocolName = String

let kService: String = "service"
let kImpl: String = "impl"

open class BHServiceManager {
    
    // MARK: Public
    open static let shared = BHServiceManager()
    open var isEnableException: Bool = false
    
    var allServices: [[AnyHashable: String]] = []
    var safeServices: [[AnyHashable: String]] {
        lock.lock()
        let array = allServices
        lock.unlock()
        return array
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
        allServices += serviceList
        lock.unlock()
    }
    
//    open func registerAnnotationServices() {}
    
    open func register(service: ProtocolName, implClass: AnyClass) {
        if !(implClass is BHServiceProtocol.Type) {
            assert(false, "\(NSStringFromClass(implClass)) module does not comply with BHServiceProtocol protocol")
        }
//        if implClass.conforms(to: service) && isEnableException {
//            assert(false, "\(NSStringFromClass(implClass)) module does not comply with \(NSStringFromProtocol(service)) protocol")
//        }
        if checkValid(service: service) && isEnableException {
            assert(false, "\(service) protocol has been registed")
        }
        var serviceInfo: [AnyHashable: String] = [:]
        serviceInfo[kService] = service
        serviceInfo[kImpl] = NSStringFromClass(implClass)
        
        lock.lock()
        allServices.append(serviceInfo)
        lock.unlock()
    }
    
    open func create(service: ProtocolName) -> AnyObject? {
        if !checkValid(service: service) && isEnableException {
            assert(false, "\(service) protocol has been registed")
        }
        guard let implClass = serviceImplClass(service) as? BHServiceProtocol.Type else { return nil }
        
        let serviceStr = service
        if implClass.singleton() {
            var implInstance = BHContext.shared.getServiceInstance(fromServiceName: serviceStr)
            if implInstance == nil {
                implInstance = implClass.shareInstance() ?? (implClass.init() as! AnyObject)
            }
            BHContext.shared.addService(withImplInstance: implInstance!, serviceName: serviceStr)
            return implInstance!
        } else {
            return implClass.shareInstance() ?? (implClass.init() as! AnyObject)
        }
        return nil
    }
    
    // MARK: Private
    
    func serviceImplClass(_ service: ProtocolName) -> AnyClass? {
        for serviceInfo: [AnyHashable: String] in safeServices {
            if let protocolStr = serviceInfo[kService], protocolStr == service {
                guard let classStr = serviceInfo[kImpl] else {
                    return nil
                }
                return NSClassFromString(classStr)
            }
        }
        return nil
    }
    
    func checkValid(service: ProtocolName) -> Bool {
        for serviceInfo: [AnyHashable: Any] in safeServices {
        var protocolStr: String? = (serviceInfo[kService] as? String)
            if (protocolStr == service) {
                return true
            }
        }
        return false
    }
    
}
