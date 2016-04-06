//
//  AppDelegate.swift
//  Selfigram
//
//  Created by han xu on 2016-03-10.
//  Copyright © 2016 xhan91. All rights reserved.
//

import UIKit
import Bolts
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // MARK: Parse part
        
        Post.registerSubclass()
        Parse.setApplicationId("qpcf91x0NvWQFNXkoCs5oncu9PKn3MiQmF9qbuBW",
                               clientKey:"XYOGnzcNNH5V4tscG47ecIg9BzRQSG5tlBtaCPWf")
        
        let user = PFUser()
        let username = "josh"
        let password = "xinxin129"
        user.username = username
        user.password = password
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("successfully signed up a user")
            }else {
                PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
                    if let username = user?.username {
                        print("successfully logged in \(username)")
                    } else {
                        print("wrong password")
                    }
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

