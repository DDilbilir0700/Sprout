//
//  AppDelegate.swift
//  Sprout
//
//  Created by Deniz Dilbilir on 13/10/2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        
        do {
            _ = try Realm()
        }catch {
            print("Error while initializing realm \(error)")
        }
        
        
        return true
    }
    
    
    
}
