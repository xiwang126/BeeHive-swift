//
// Created by UgCode on 2017/3/13.
//

import Foundation

public enum BHEnvironmentType {
    case dev
    case test
    case stage
    case prod
}

public class BHContext {
    public static let shared = BHContext()
    
    var modulesByName: [AnyHashable: Any] = [:]
    var servicesByName: [AnyHashable: Any] = [:]
    
    //global env
    public var env = BHEnvironmentType.stage

    //global config
    public var config = BHConfig()

    //application appkey
    public var appkey: String = ""

    //customEvent>=1000
    public var customEvent: Int = 0

    public var application: UIApplication!
    public var launchOptions: [AnyHashable: Any] = [:]
    public var moduleConfigName: String = "BeeHive.bundle/BeeHive"
    public var serviceConfigName: String = "BeeHive.bundle/BHService"
    
    //3D-Touch model
    public var touchShortcutItem = BHShortcutItem()

    //OpenURL model
    public var openURLItem = BHOpenURLItem()

    //Notifications Remote or Local
    public var notificationsItem = BHNotificationsItem()

    //user Activity Model
    public var userActivityItem = BHUserActivityItem()

    init() {}

    public func addService(withImplInstance implInstance: Any, serviceName: String) {
        BHContext.shared.servicesByName[serviceName] = implInstance
    }

    public func getServiceInstance(fromServiceName serviceName: String) -> Any {
        return BHContext.shared.servicesByName[serviceName]
    }
}
