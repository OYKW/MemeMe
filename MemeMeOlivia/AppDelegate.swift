//
//  AppDelegate.swift
//  MemeMeOlivia
//
//  Created by Olivia Wang on 4/10/15.
//  Copyright (c) 2015 Halfspace. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Defined data to be shared among view controllers
    var memes = [Meme]()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    


}

