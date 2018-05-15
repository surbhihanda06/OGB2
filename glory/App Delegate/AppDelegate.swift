//
//  AppDelegate.swift
//  glory
//
//  Created by navjot_sharma on 10/10/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown
import FBSDKCoreKit
import GoogleSignIn
import Google

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate
{
    var window: UIWindow?
    var navigationController:UINavigationController?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool
    {
        DropDown.startListeningToKeyboard()
        // Override point for customization after application launch.
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: buttonColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
        
        IQKeyboardManager.sharedManager().enable = true
        
        if defaults.value(forKey: dquote_id) != nil
        {
            globalStrings.Quote_id = defaults.value(forKey: dquote_id) as! String
        }
        if  defaults.integer(forKey: dquote_count) != 0
        {
            globalStrings.Quote_count = defaults.value(forKey: dquote_count) as! Int
            
            if Int(globalStrings.Quote_count) > 0
            {
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                let tabArray = tabBarController?.tabBar.items as NSArray!
                let chatItem = tabArray?.object(at: 2) as! UITabBarItem
                if #available(iOS 10.0, *)
                {
                    chatItem.badgeColor = buttonColor
                } else {
                }
                chatItem.badgeValue = String(globalStrings.Quote_count)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBarController
            }
            else
            {
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                let tabArray = tabBarController?.tabBar.items as NSArray!
                let chatItem = tabArray?.object(at: 2) as! UITabBarItem
                chatItem.badgeValue = nil
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBarController
            }
        }
        if  defaults.value(forKey: dcust_id) != nil
        {
            globalStrings.Cust_id = defaults.value(forKey: dcust_id) as! String
        }
        UIApplication.shared.statusBarStyle = .lightContent
        DispatchQueue.main.async
        {
                let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        GIDSignIn.sharedInstance().clientID = "833976256756-1mfqto6ulvm2hge1refts7b2f4men7nv.apps.googleusercontent.com"
       // GIDSignIn.sharedInstance().delegate = self
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions) || true
    }
    
    //handler
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]) ||
            
            GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func application(application: UIApplication, openURL url: NSURL, options: [UIApplicationOpenURLOptionsKey : Any], sourceApplication: String?, annotation: AnyObject) -> Bool
    {
        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return  facebookDidHandle
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings)
    {
        if notificationSettings.types != UIUserNotificationType() {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print(token)
        defaults.setValue(token, forKey: ddevice_id)
    }
    
    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationProtectedDataWillBecomeUnavailable(_ _application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        FBSDKAppEvents.activateApp()
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func showAlertWithTitle(_ title:String, message:(String))   {
        self.navigationController = UIApplication.shared.windows[0].rootViewController as? UINavigationController
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert )
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {Void in})
        alert.addAction(action)
        self.navigationController!.present(alert, animated: true, completion:nil)
    }
}
