//
//  BHAppDelegate.swift
//  Pods
//
//  Created by UgCode on 2017/3/13.
//
//

import Foundation
import UIKit

public typealias NotificationResultHandler = (UIBackgroundFetchResult) -> Void

public struct BHNotificationsItem {
    var notificationsError: Error?
    var deviceToken: Data?
    var userInfo: [AnyHashable: Any] = [:]
    var notificationResultHander: NotificationResultHandler?
    var localNotification: UILocalNotification?
}

public struct BHOpenURLItem {
    var openURL: URL?
    var sourceApplication: String = ""
    var options: [AnyHashable: Any] = [:]
}

typealias ShortcutItemCompletionHandler = (Bool) -> Void

public struct BHShortcutItem {
    var shortcutItem: UIApplicationShortcutItem?
    var scompletionHandler: ShortcutItemCompletionHandler?
}

public typealias RestorationHandler = ([Any]?) -> Void

public struct BHUserActivityItem {
    var userActivityType: String = ""
    var userActivity: NSUserActivity?
    var userActivityError: Error?
    var restorationHandler: RestorationHandler?
}

open class BHAppDelegate: UIResponder, UIApplicationDelegate {

    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BHContext.shared.application = application
        BHContext.shared.launchOptions = launchOptions ?? [:]
        BeeHive.shared.context = BHContext.shared
        
        BHModuleManager.shared.triggerEvent(.setupEvent)
        BHModuleManager.shared.triggerEvent(.initEvent)

        DispatchQueue.main.async {
            BHModuleManager.shared.triggerEvent(.splashEvent)
        }
        
        #if DEBUG
            //TODO: TimeProfile
        #endif
        return true
    }

    open func applicationDidBecomeActive(_ application: UIApplication) {
        BHModuleManager.shared.triggerEvent(.didBecomeActiveEvent)
    }

    open func applicationWillResignActive(_ application: UIApplication) {
        BHModuleManager.shared.triggerEvent(.willResignActiveEvent)
    }

    open func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        BeeHive.shared.context.openURLItem.openURL = url
        BeeHive.shared.context.openURLItem.sourceApplication = sourceApplication ?? ""
        BHModuleManager.shared.triggerEvent(.openURLEvent)
        return true
    }

    open func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        BeeHive.shared.context.openURLItem.openURL = url
        BeeHive.shared.context.openURLItem.options = options
        BHModuleManager.shared.triggerEvent(.openURLEvent)
        return true
    }

    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        BHModuleManager.shared.triggerEvent(.didReceiveMemoryWarningEvent)
    }

    open func applicationWillTerminate(_ application: UIApplication) {
        BHModuleManager.shared.triggerEvent(.willTerminateEvent)
    }

    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        BeeHive.shared.context.notificationsItem.deviceToken = deviceToken
        BHModuleManager.shared.triggerEvent(.didRegisterForRemoteNotificationsEvent)
    }

    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        BeeHive.shared.context.notificationsItem.notificationsError = error
        BHModuleManager.shared.triggerEvent(.didFailToRegisterForRemoteNotificationsEvent)
    }

    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        BeeHive.shared.context.notificationsItem.userInfo = userInfo
        BHModuleManager.shared.triggerEvent(.didReceiveRemoteNotificationEvent)
    }

    open func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        BeeHive.shared.context.notificationsItem.localNotification = notification
        BHModuleManager.shared.triggerEvent(.didReceiveLocalNotificationEvent)
    }

    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        BeeHive.shared.context.notificationsItem.userInfo = userInfo
        BeeHive.shared.context.notificationsItem.notificationResultHander = completionHandler
        BHModuleManager.shared.triggerEvent(.didReceiveRemoteNotificationEvent)
    }

    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        BeeHive.shared.context.touchShortcutItem.shortcutItem = shortcutItem
        BeeHive.shared.context.touchShortcutItem.scompletionHandler = completionHandler
        BHModuleManager.shared.triggerEvent(.quickActionEvent)
    }

    open func applicationDidEnterBackground(_ application: UIApplication) {
        BHModuleManager.shared.triggerEvent(.didEnterBackgroundEvent)
    }

    open func applicationWillEnterForeground(_ application: UIApplication) {
        BHModuleManager.shared.triggerEvent(.willEnterForegroundEvent)
    }

    open func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        BeeHive.shared.context.userActivityItem.userActivityType = userActivityType
        BHModuleManager.shared.triggerEvent(.willContinueUserActivityEvent)
        return true
    }

    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        BeeHive.shared.context.userActivityItem.userActivity = userActivity
        BeeHive.shared.context.userActivityItem.restorationHandler = restorationHandler
        BHModuleManager.shared.triggerEvent(.continueUserActivityEvent)
        return true
    }

    open func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        BeeHive.shared.context.userActivityItem.userActivityType = userActivityType
        BeeHive.shared.context.userActivityItem.userActivityError = error
        BHModuleManager.shared.triggerEvent(.didFailToContinueUserActivityEvent)
    }

    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        BeeHive.shared.context.userActivityItem.userActivity = userActivity
        BHModuleManager.shared.triggerEvent(.didUpdateUserActivityEvent)
    }

}
