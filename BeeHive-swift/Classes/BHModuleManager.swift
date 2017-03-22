//
// Created by UgCode on 2017/3/13.
//

import Foundation

public enum BHModuleLevel {
    case basic, normal
}

public enum BHModuleEventType: Int {
    case setupEvent = 0
    case initEvent
    case tearDownEvent
    case splashEvent
    case quickActionEvent
    case willResignActiveEvent
    case didEnterBackgroundEvent
    case willEnterForegroundEvent
    case didBecomeActiveEvent
    case willTerminateEvent
    case unmountEvent
    case openURLEvent
    case didReceiveMemoryWarningEvent
    case didFailToRegisterForRemoteNotificationsEvent
    case didRegisterForRemoteNotificationsEvent
    case didReceiveRemoteNotificationEvent
    case didReceiveLocalNotificationEvent
    case willContinueUserActivityEvent
    case continueUserActivityEvent
    case didFailToContinueUserActivityEvent
    case didUpdateUserActivityEvent
    case didCustomEvent = 1000
}

let kModuleArrayKey = "moduleClasses"
let kModuleInfoNameKey = "moduleClass"
let kModuleInfoLevelKey = "moduleLevel"

class BHModuleManager {
    
    public static let shared = BHModuleManager()
    var modules: [[AnyHashable: Any]] = []
    var moduleInstances: [BHModuleProtocol] = []

    ///If you do not comply with set Level protocol, the default Normal
    public func registerDynamicModule(_ moduleClass: AnyClass) {
        let className = NSStringFromClass(moduleClass)
        guard let moduleClass = moduleClass as? BHModuleProtocol.Type else {
            assert(false, "\(className) module does not comply with BHModuleProtocol protocol")
            return
        }
        let level = moduleClass.moduleLevel()
        
        var moduleInfo: [AnyHashable: Any] = [:]
        moduleInfo[kModuleInfoLevelKey] = level
        moduleInfo[kModuleInfoNameKey] = className
        
        self.modules.append(moduleInfo)
    }

    public func loadLocalModules() {
        guard let plistPath = Bundle.main.path(forResource: BHContext.shared.moduleConfigName, ofType: "plist") else {
            assert(false, "config file path error")
            return
        }
        guard let moduleList = NSDictionary(contentsOfFile: plistPath) else {
            assert(false, "read config error")
            return
        }
        guard let modulesArray = moduleList[kModuleArrayKey] as? [[AnyHashable: Any]] else { return }
        modules += modulesArray
    }

    public func registedAllModules() {
        modules.sort { (module1, module2) -> Bool in
            let level1 = module1[kModuleInfoLevelKey] as! Int
            let level2 = module2[kModuleInfoLevelKey] as! Int
            return level1 > level2
        }

        for module in modules {
            if let classSrt = module[kModuleInfoNameKey] as? String,
                let moduleClass = NSClassFromString(classSrt) as? BHModuleProtocol.Type {
                let moduleInstance = moduleClass.init(BHContext.shared)
                moduleInstances.append(moduleInstance)
            }
        }
    }

//    public func registedAnnotationModules() {}

    public func triggerEvent(_ eventType: BHModuleEventType) {
        switch eventType {
        case .setupEvent: handleModulesSetupEvent()
        case .tearDownEvent: handleModulesTearDownEvent()
        default: handleModuleEvent(eventType)
        }
    }

    //MARK: Private
    
    func checkModule(level: Int) -> BHModuleLevel {
        switch level {
        case 0:
            return .basic
        case 1:
            return .normal
        default:
            return .normal
        }
    }
    
    func handleModulesSetupEvent() {
        for instance in moduleInstances {
            let bk: () -> Void = {
                instance.modSetUp(BHContext.shared)
            }
            if instance.async() {
                DispatchQueue.main.async {
                    bk()
                }
            } else {
                bk()
            }
        }
    }
    
    func handleModulesTearDownEvent() {
        for index in (moduleInstances.count - 1)...0 {
            moduleInstances[index].modTearDown(BHContext.shared)
        }
    }

    func handleModuleEvent(_ eventType: BHModuleEventType) {
        for instance in moduleInstances {
            switch eventType {
            case .splashEvent: instance.modSplash(BHContext.shared)
            case .willResignActiveEvent: instance.modWillResignActive(BHContext.shared)
            case .didEnterBackgroundEvent: instance.modDidEnterBackground(BHContext.shared)
            case .willEnterForegroundEvent: instance.modWillEnterForeground(BHContext.shared)
            case .didBecomeActiveEvent: instance.modDidBecomeActive(BHContext.shared)
            case .willTerminateEvent: instance.modWillTerminate(BHContext.shared)
            case .unmountEvent: instance.modUnmount(BHContext.shared)
            case .openURLEvent: instance.modOpenURL(BHContext.shared)
            case .didReceiveMemoryWarningEvent: instance.modDidReceiveMemoryWaring(BHContext.shared)
            case .didReceiveRemoteNotificationEvent: instance.modDidReceiveRemoteNotification(BHContext.shared)
            case .didFailToRegisterForRemoteNotificationsEvent: instance.modDidFailToRegister(forRemoteNotifications: BHContext.shared)
            case .didRegisterForRemoteNotificationsEvent: instance.modDidRegister(forRemoteNotifications: BHContext.shared)
            case .didReceiveLocalNotificationEvent: instance.modDidReceiveLocalNotification(BHContext.shared)
            case .willContinueUserActivityEvent: instance.modWillContinueUserActivity(BHContext.shared)
            case .continueUserActivityEvent: instance.modContinueUserActivity(BHContext.shared)
            case .didFailToContinueUserActivityEvent: instance.modDidFail(toContinueUserActivity: BHContext.shared)
            case .didUpdateUserActivityEvent: instance.modDidUpdateContinueUserActivity(BHContext.shared)
            case .quickActionEvent: instance.modQuickAction(BHContext.shared)
            default:
                //TODO: cuntom event
                //BHContext.shared.customEvent = 1001
                instance.modDidCustomEvent(BHContext.shared)
            }
        }
    }
}
