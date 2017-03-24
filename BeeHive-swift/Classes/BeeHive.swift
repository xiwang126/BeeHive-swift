//
// Created by UgCode on 2017/3/13.
//

import Foundation

public class BeeHive {
    public static let shared = BeeHive()

    //save application global context
    
    private let _onceToken = NSUUID().uuidString
    public var context: BHContext {
        didSet {
            DispatchQueue.once(token: _onceToken) {
                loadStaticModules()
                loadStaticServices()
            }
        }
    }

    public var isEnableException: Bool = false

    /// 必须在给context赋值之前注册要动态注册的module
    public static func registerDynamicModule(_ moduleClass: AnyClass) {
        BHModuleManager.shared.registerDynamicModule(moduleClass)
    }

    public static func triggerCustomEvent(_ eventType: Int) {
        if eventType > 1000 {
            return
        }
        BHModuleManager.shared.triggerEvent(BHModuleEventType(rawValue: eventType)!)
    }

    init() {
        self.context = BHContext.shared
    }

    public func createService(_ proto: ProtocolName) throws -> AnyObject {
        return try BHServiceManager.shared.create(service: proto)
    }

    //Registration is recommended to use a static way
    public func registerService(_ proto: ProtocolName, service serviceClass: AnyClass) {
        BHServiceManager.shared.register(service: proto, implClass: serviceClass)
    }

    private func loadStaticModules() {
        BHModuleManager.shared.loadLocalModules()
        BHModuleManager.shared.registedAllModules()
    }

    private func loadStaticServices() {
        BHServiceManager.shared.isEnableException = isEnableException
        BHServiceManager.shared.registerLocalServices()
    }
}

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    class func once(token: String, block: (Void)->Void) {
        objc_sync_enter(self);
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
