//
//  AppDelegate.swift
//  PM_PRO_J
//
//  Created by Travis Allen on 10/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//

import UIKit
import LS2SDK
import UIKit
import ResearchSuiteTaskBuilder
import ResearchSuiteResultsProcessor
import Gloss
import sdlrkx
import UserNotifications
import LS2SDK
import ResearchSuiteExtensions
import ResearchSuiteAppFramework

//<string name="ls2_base_url">https://mobileappdev.ctsc.med.cornell.edu/dsu</string>
//<string name="ls2_queue_directory">LS2Queue</string>
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var store: RSStore!
    var taskBuilder: RSTBTaskBuilder!
    var resultsProcessor: RSRPResultsProcessor!
    //    var CSVBackend: RSRPCSVBackEnd!
    var ls2Manager: LS2Manager!
    var ls2Backend: LS2BackEnd!
    
    //    var store: RSCredentialsStore!
    
    
    static var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    @available(iOS 10.0, *)
    var center: UNUserNotificationCenter!{
        return UNUserNotificationCenter.current()
    }
    
    func initializeLS2(credentialStore: RSCredentialsStore, config: String, logger: RSLogger?) -> LS2Manager {
        guard let file = Bundle.main.path(forResource: "LS2Client", ofType: "plist") else {
            fatalError("Could not initialze LS2Manager")
        }
        
        
        let clientDetails = NSDictionary(contentsOfFile: file)
        
        guard let configDict = clientDetails?[config] as? [String: String],
            let baseURL = configDict["baseURL"] else {
                fatalError("Could not initialze LS2Manager")
        }
        
        let manager: LS2Manager? = {
            return LS2Manager(
                baseURL: baseURL,
                queueStorageDirectory: "ls2SDKCache",
                store: credentialStore,
                logger: logger
            )
        }()
        
        if let m = manager {
            return m
        }
        else {
            fatalError("Could not initialze LS2 Manager")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.ls2Manager = LS2Manager(baseURL: "https://mobileappdev.ctsc.med.cornell.edu/dsu", queueStorageDirectory: "LS2Queue", store: LS2Store() as! RSCredentialStore)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

